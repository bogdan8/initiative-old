class ChangeNameTebleInitiativesCategoriesToInitiativeCategories < ActiveRecord::Migration
  def change
    rename_table :initiatives_categories, :initiative_categories
  end
end
