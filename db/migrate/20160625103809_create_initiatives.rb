class CreateInitiatives < ActiveRecord::Migration
  def change
    create_table :initiatives do |t|
      t.string :title
      t.text :main_video
      t.string :short_description
      t.text :long_description
      t.integer :sum
      t.integer :term_fundraiser
      t.integer :term_report

      t.timestamps null: false
    end
  end
end
