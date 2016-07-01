class Category < ActiveRecord::Base
  has_many :initiative_categories
  has_many :initiatives, through: :initiative_categories

  scopify
end
