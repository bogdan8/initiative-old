class Initiative < ActiveRecord::Base
  validates :short_description, length: { maximum: 200 }
  validates :sum, format: { with: /\A\d{3,5}\b/ }
  validates :term_fundraiser, format: { with: /\A30\b|\A60\b/ }
  validates :term_report, format: { with: /\A15\b|\A30\b/ }
end
