require 'spec_helper'

describe Category, type: :model do
  describe '#test for associations' do
    it { should have_many(:initiative_category) }
    it { should have_many(:initiatives).through(:initiative_category) }
  end
end
