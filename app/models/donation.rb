class Donation < ActiveRecord::Base
  belongs_to :initiative
  belongs_to :user

  include AASM

  aasm do
    state :paid, initial: true
    state :transferred_user

    event :Money_transferred_to_the_user do
      transitions from: :paid, to: :transferred_user
    end
  end
  scopify

  validate :validate_amount

  private

  def validate_amount
    trans_error_amount = I18n.t('activerecord.errors.models.donate.attributes.amount.correct_number')
    errors.add(:amount, trans_error_amount) unless amount.between?(1, 9_999)
  end
end
