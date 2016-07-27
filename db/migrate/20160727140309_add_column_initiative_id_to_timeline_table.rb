class AddColumnInitiativeIdToTimelineTable < ActiveRecord::Migration
  def change
    add_column :timelines, :initiative_id, :integer
  end
end
