class InitiativeCategory < ActiveRecord::Base
  belongs_to :initiative
  belongs_to :category

  scopify
end
