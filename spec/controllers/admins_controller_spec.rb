require 'rails_helper'

describe AdminsController, type: :controller do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    @user.add_role :admin
    @user.confirm
    sign_in @user
    create(:initiative, user_id: @user.id)
  end
  describe '#GET #index' do
    subject { get :index }

    it '#renders the index template' do
      expect(subject).to render_template(:index)
      expect(subject).to render_template('index')
      expect(subject).to render_template('admins/index')
    end

    it '#does not render a different template' do
      expect(subject).to_not render_template('admins/show')
    end
  end
  describe '#GET #new' do
    subject { get :new }

    it '#renders the new template' do
      expect(subject).to render_template(:new)
      expect(subject).to render_template('new')
      expect(subject).to render_template('admins/new')
    end

    it '#does not render a different template' do
      expect(subject).to_not render_template('admins/index')
    end
  end
end
