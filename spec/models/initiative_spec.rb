require 'spec_helper'

describe Initiative, type: :model do
  describe '#test for associations' do
    it { should belong_to :user }
    it { should have_many :initiative_images }
    it { should have_many :initiative_categories }
    it { should have_many :categories }
    it { should have_many :timelines }
  end

  describe '#test for validations' do
    it '#is sum between 100 and 50000' do
      initiative = create(:initiative)
      expect(initiative.sum).to be_between(100, 50_000).inclusive
    end
    it '#is title not be empty' do
      initiative = create(:initiative)
      expect(initiative.title).not_to be_empty
    end
    it '#is long_description not be empty' do
      initiative = create(:initiative)
      expect(initiative.long_description).not_to be_empty
    end
    it '#is term_fundraiser must be 30 or 60' do
      initiative = create(:initiative)
      expect(initiative.term_fundraiser).to eq(30 || 60)
    end
    it '#is term_report must be 15 or 30' do
      initiative = create(:initiative)
      expect(initiative.term_report).to eq(15 || 30)
    end
  end
end
