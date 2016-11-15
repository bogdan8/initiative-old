class Category < ActiveRecord::Base
  has_many :initiative_category
  has_many :initiatives, through: :initiative_category

  acts_as_list

  scopify
end
