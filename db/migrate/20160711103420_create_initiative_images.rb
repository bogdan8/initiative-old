class CreateInitiativeImages < ActiveRecord::Migration
  def change
    create_table :initiative_images do |t|
      t.integer :initiative_id
      t.string :title
    end
  end
end
