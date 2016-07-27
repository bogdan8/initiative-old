require 'rails_helper'

describe SearchController, type: :controller do
  describe '#GET #index' do
    subject { get :index }

    it '#renders the index template' do
      expect(subject).to render_template(:index)
      expect(subject).to render_template('index')
      expect(subject).to render_template('search/index')
    end

    it '#does not render a different template' do
      expect(subject).to_not render_template('search/show')
    end
  end
end
