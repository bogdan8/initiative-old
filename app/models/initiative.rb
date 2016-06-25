class Initiative < ActiveRecord::Base
  validates :title, presence: true
  validates :long_description, presence: true
  validates :short_description, length: { maximum: 200 }
  validates :sum, format: { with: /\A\d{3,5}\b/ }
  validates :term_fundraiser, format: { with: /\A30\b|\A60\b/ }
  validates :term_report, format: { with: /\A15\b|\A30\b/ }

  has_attached_file :main_picture, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :main_picture, content_type: /\Aimage\/.*\Z/
end
