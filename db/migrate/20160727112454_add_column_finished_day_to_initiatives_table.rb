class AddColumnFinishedDayToInitiativesTable < ActiveRecord::Migration
  def change
    add_column :initiatives, :finished_day, :date
  end
end
