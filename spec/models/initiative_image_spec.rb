require 'spec_helper'

describe InitiativeImage, type: :model do
  describe '#test for image' do
    it '#add initiative_images' do
      should have_attached_file(:initiative_images)
      should validate_attachment_content_type(:initiative_images).
               allowing('image/png', 'image/gif').
               rejecting('text/plain', 'text/xml')
    end
  end
end
