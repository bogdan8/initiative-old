require 'spec_helper'

describe Initiative, type: :model do
  describe 'test for associations' do
    it { should belong_to :user }
    it { should have_many :initiative_images }
    it { should have_many :initiative_categories }
    it { should have_many :categories }
  end
end
