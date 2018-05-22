require 'rails_helper'

describe HomeController, type: :controller do
  before(:each) do
    create(:initiative)
  end
  describe '#GET #index' do
    subject { get :index }

    it '#renders the index template' do
      expect(subject).to render_template(:index)
      expect(subject).to render_template('index')
      expect(subject).to render_template('home/index')
    end

    it '#does not render a different template' do
      expect(subject).to_not render_template('home/show')
    end
  end
end
