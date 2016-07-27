require 'rails_helper'

describe CategoriesController, type: :controller do
  let(:valid_session) { {} }
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    @user.confirm
    sign_in @user
    create(:initiative, user_id: @user.id)
  end
  describe '#GET #index' do
    subject { get :index }

    it '#renders the index template' do
      expect(subject).to render_template(:index)
      expect(subject).to render_template('index')
      expect(subject).to render_template('categories/index')
    end

    it '#does not render a different template' do
      expect(subject).to_not render_template('categories/edit')
    end
  end
  describe '#GET #new' do
    it '#assigns a new category as @category' do
      get :new, {}, valid_session
      expect(assigns(:category)).to be_a_new(Category)
    end
  end
end
