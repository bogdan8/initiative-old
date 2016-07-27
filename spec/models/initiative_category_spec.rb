require 'spec_helper'

describe InitiativeCategory, type: :model do
  describe '#test for associations' do
    it { should belong_to :initiative }
    it { should belong_to :category }
  end
end
