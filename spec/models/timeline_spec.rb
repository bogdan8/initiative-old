require 'spec_helper'

describe Timeline, type: :model do
  describe '#test for validations' do
    it { should validate_presence_of :title }
  end
  describe '#test for associations' do
    it { should belong_to :initiative }
  end
end
