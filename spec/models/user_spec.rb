require 'spec_helper'

describe User, type: :model do
  describe '#test for associations' do
    it { should have_many :initiatives }
  end
  describe '#test for image' do
    it '#add avatar' do
      should have_attached_file(:avatar)
      should validate_attachment_content_type(:avatar).
               allowing('image/png', 'image/gif').
               rejecting('text/plain', 'text/xml')
    end
  end
end
