require 'spec_helper'

describe User, type: :model do
  describe 'test for associations' do
    it { should have_many :initiatives }
  end
end
