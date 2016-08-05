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
end
