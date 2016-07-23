require 'spec_helper'

describe Timeline, type: :model do
  describe 'test for validations' do
    it { should validate_presence_of :title }
  end
end
