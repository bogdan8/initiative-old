class Initiative < ActiveRecord::Base
  size_main_picture = { medium: '300x300>', thumb: '100x100>' }
  path_main_picture = ':rails_root/public/images/:class/:attachment/:id/:style/:filename'

  belongs_to :user
  has_many :initiative_images, dependent: :destroy
  has_many :initiative_categories
  has_many :categories, through: :initiative_categories
  has_many :timelines
  has_many :donations

  include AASM

  aasm do
    state :draft, initial: true
    state :pending_approval
    state :rejected
    state :fundraiser
    state :fundraising_finished
    state :being_implemented
    state :audit_implemented
    state :implemented
    state :unrealized
    state :locked

    event :submit_for_confirmation do
      transitions from: [:draft, :rejected], to: :pending_approval
    end

    event :success_confirmation do
      transitions from: :pending_approval, to: :fundraiser
    end

    event :error_confirmation do
      transitions from: [:pending_approval, :draft, :fundraiser], to: :rejected
    end

    event :finish_fundraising do
      transitions from: :fundraiser, to: :fundraising_finished
    end

    event :started_implement do
      transitions from: :fundraising_finished, to: :being_implemented
    end

    event :insufficient_funds do
      transitions from: :fundraising_finished, to: :unrealized
    end

    event :check_implemented do
      transitions from: :being_implemented, to: :audit_implemented
    end

    event :finish_fundraiser_success do
      transitions from: :audit_implemented, to: :implemented
    end

    event :finish_fundraiser_errors do
      transitions from: :audit_implemented, to: :unrealized
    end

    event :locked_forever do
      transitions to: :locked
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
                    url: '/images/:class/:attachment/:id/:style/:filename',
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :main_picture, content_type: %r{\Aimage\/.*\Z}

  serialize :notification_params, Hash
  def paypal_url(return_url, amount)
    values = {
      cmd: '_xclick',
      charset: 'utf-8',
      business: '4orna_primara-facilitator@mail.ru',
      invoice: "#{id}_#{rand(1..50)}",
      return: "http://127.0.0.1:3000/#{return_url}",
      item_number: "#{id}_#{rand(1..50)}",
      item_name: title,
      currency_code: 'USD',
      amount: amount,
      notify_url: 'http://127.0.0.1:3000/hook'
    }
    "https://www.sandbox.paypal.com/cgi-bin/webscr?#{values.to_query}"
  end

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

  scopify
end
