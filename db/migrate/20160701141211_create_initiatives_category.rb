class CreateInitiativesCategory < ActiveRecord::Migration
  def change
    create_table :initiatives_categories do |t|
      t.integer :initiative_id
      t.integer :category_id
    end
  end
end
