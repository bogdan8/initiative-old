class AddAttachmentsMainPictureToInitiatives < ActiveRecord::Migration
  def up
    add_attachment :initiatives, :main_picture
  end

  def down
    remove_attachment :initiatives, :main_picture
  end
end
