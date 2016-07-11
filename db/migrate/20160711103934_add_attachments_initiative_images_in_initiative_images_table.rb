class AddAttachmentsInitiativeImagesInInitiativeImagesTable < ActiveRecord::Migration
  def change
    add_attachment :initiative_images, :initiative_images
  end
end
