class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      t.string :title
      t.datetime :date
      t.text :description

      t.timestamps null: false
    end
  end
end
