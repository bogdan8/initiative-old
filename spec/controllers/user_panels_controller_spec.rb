require 'rails_helper'

describe UserPanelsController, type: :controller do
  before(:each) do
    login_user
    create(:initiative, user_id: @user.id)
  end
  describe '#GET #index' do
    subject { get :index }

    it '#renders the index template' do
      expect(subject).to render_template(:index)
      expect(subject).to render_template('index')
      expect(subject).to render_template('user_panels/index')
    end

    it '#does not render a different template' do
      expect(subject).to_not render_template('user_panels/show_user')
    end
  end
  describe '#GET #show_user' do
    subject { get :show_user }

    it '#renders the index template' do
      expect(subject).to render_template(:show_user)
      expect(subject).to render_template('show_user')
      expect(subject).to render_template('user_panels/show_user')
    end

    it '#does not render a different template' do
      expect(subject).to_not render_template('user_panels/index')
    end
  end
end
