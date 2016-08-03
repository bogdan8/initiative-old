class User < ActiveRecord::Base
  after_create :assign_default_role
  after_create :send_user_mail_welcome

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.avatar_file_name = auth.info.image unless auth.info.image.nil?
      user.name = auth.info.name
      user.email = auth.info.email unless auth.info.email.nil?
      user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def assign_default_role
    add_role(:user)
  end

  def send_user_mail_welcome
    UserMailer.send_message_welcome_to_new_user(self).deliver_later
  end

  size_avatar = { medium: '300x300>', thumb: '100x100>' }
  path_avatar = ':rails_root/public/images/:attachment/:id/:style/:filename'

  rolify
  has_many :initiatives
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_attached_file :avatar,
                    styles: size_avatar,
                    path: path_avatar,
                    url: '/images/:attachment/:id/:style/:filename',
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}
end
