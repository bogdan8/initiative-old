class Initiative < ActiveRecord::Base
  belongs_to :user
  has_one :timeline

  include AASM

  scope :open_initiatives, -> { where(aasm_state: 'open') }

  aasm do
    state :fundraiser, initial: true
    state :launched
    state :implemented
    state :unrealized

    event :fundraiser do
      transitions from: :fundraiser, to: :launched
    end

    event :launched do
      transitions from: :launched, to: [:implemented, :uncached]
    end
  end

  validates :title, presence: true
  validates :long_description, presence: true
  validates :short_description, length: { maximum: 200 }
  validate :validate_sum
  validate :validate_term_fundraiser
  validate :validate_term_report

  has_attached_file :main_picture, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :main_picture, content_type: %r{\Aimage\/.*\Z}

  def validate_sum
    errors.add(:sum, 'Число має бути більше чим 100 і менше чим 50000') unless sum >= 100 && sum <= 50_000
  end

  def validate_term_fundraiser
    errors.add(:term_fundraiser, 'Ви вели невірне число') unless term_fundraiser == 30 || term_fundraiser == 60
  end

  def validate_term_report
    errors.add(:term_report, 'Ви вели невірне число') unless term_report == 15 || term_report == 30
  end
end
