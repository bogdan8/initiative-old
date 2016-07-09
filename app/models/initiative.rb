class Initiative < ActiveRecord::Base
  size_main_picture = { medium: '300x300>', thumb: '100x100>' }
  path_main_picture = ':rails_root/public/images/:attachment/:id/:style/:filename'

  belongs_to :user
  has_one :timeline
  has_many :initiative_categories
  has_many :categories, through: :initiative_categories

  include AASM

  aasm do
    state :pending_approval, initial: true
    state :rejected
    state :fundraiser
    state :implemented
    state :unrealized

    event :success_confirmation do
      transitions from: :pending_approval, to: :fundraiser
    end

    event :error_confirmation do
      transitions from: :pending_approval, to: :rejected
    end

    event :success_fundraiser do
      transitions from: :launched, to: :implemented
    end

    event :error_fundraiser do
      transitions from: :launched, to: :unrealized
    end
  end

  validates :title, presence: true
  validates :long_description, presence: true
  validates :short_description, length: { maximum: 200 }
  validate :validate_sum
  validate :validate_term_fundraiser
  validate :validate_term_report

  has_attached_file :main_picture,
                    styles: size_main_picture,
                    path: path_main_picture,
                    url: '/images/:attachment/:id/:style/:filename',
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :main_picture, content_type: %r{\Aimage\/.*\Z}

  private

  def validate_sum
    trans_error_sum = I18n.t('activerecord.errors.models.initiative.attributes.sum.correct_number')
    errors.add(:sum, trans_error_sum) unless sum.between?(100, 50_000)
  end

  def validate_term_fundraiser
    trans_error_term_fundraiser = I18n.t('activerecord.errors.models.initiative.attributes.term_fundraiser')
    errors.add(:term_fundraiser, trans_error_term_fundraiser) unless term_fundraiser == 30 || term_fundraiser == 60
  end

  def validate_term_report
    trans_error_term_report = I18n.t('activerecord.errors.models.initiative.attributes.term_report')
    errors.add(:term_report, trans_error_term_report) unless term_report == 15 || term_report == 30
  end
end
