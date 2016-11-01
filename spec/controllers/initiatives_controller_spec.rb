require 'rails_helper'

describe InitiativesController, type: :controller do
  let(:initiative) { create(:initiative, user_id: @user.id) }
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
      expect(subject).to render_template('initiatives/index')
    end

    it '#does not render a different template' do
      expect(subject).to_not render_template('initiatives/show')
    end
  end
  describe '#GET #new' do
    subject { get :new }

    it '#renders the new template' do
      expect(subject).to render_template(:new)
      expect(subject).to render_template('new')
      expect(subject).to render_template('initiatives/new')
    end

    it '#does not render a different template' do
      expect(subject).to_not render_template('initiatives/index')
    end
  end

  context 'AASM state' do
    describe '# GET for_confirmation # and returns http ' do
      it 'for_confirmation' do
        initiative.update(aasm_state: :draft)
        xhr :get, :for_confirmation, id: initiative.id
        expect(response).to have_http_status(302)
        expect(initiative.reload).to be_pending_approval
      end

      it 'success_confirmation' do
        initiative.update(aasm_state: :pending_approval)
        xhr :get, :success_confirmation, id: initiative.id
        expect(response).to have_http_status(302)
        expect(initiative.reload).to be_fundraiser
      end

      it 'error_confirmation' do
        initiative.update(aasm_state: :draft)
        xhr :get, :error_confirmation, id: initiative.id
        expect(response).to have_http_status(302)
        expect(initiative.reload).to be_rejected
      end

      it 'started_implement' do
        initiative.update(aasm_state: :fundraising_finished)
        xhr :get, :started_implement, id: initiative.id
        expect(response).to have_http_status(302)
        expect(initiative.reload).to be_being_implemented
      end

      it 'insufficient_funds' do
        initiative.update(aasm_state: :fundraising_finished)
        xhr :get, :insufficient_funds, id: initiative.id
        expect(response).to have_http_status(302)
        expect(initiative.reload).to be_unrealized
      end

      it 'finish_fundraiser_success' do
        initiative.update(aasm_state: :audit_implemented)
        xhr :get, :implemented, id: initiative.id
        expect(response).to have_http_status(302)
        expect(initiative.reload).to be_implemented
      end

      it 'finish_fundraiser_errors' do
        initiative.update(aasm_state: :audit_implemented)
        xhr :get, :unrealized, id: initiative.id
        expect(response).to have_http_status(302)
        expect(initiative.reload).to be_unrealized
      end

      it 'locked' do
        xhr :get, :locked, id: initiative.id
        expect(response).to have_http_status(302)
        expect(initiative.reload).to be_locked
      end
    end
  end
end
