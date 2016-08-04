class AddColumnVideoToTimelineTable < ActiveRecord::Migration
  def change
    add_column :timelines, :video, :text
  end
end
