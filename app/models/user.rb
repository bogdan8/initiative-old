class User < ActiveRecord::Base
  size_avatar = { medium: '300x300>', thumb: '100x100>' }
  path_avatar = ':rails_root/public/images/:attachment/:id/:style/:filename'

  rolify
  has_many :initiatives
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar,
                    styles: size_avatar,
                    path: path_avatar,
                    url: '/images/:attachment/:id/:style/:filename',
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}
end
