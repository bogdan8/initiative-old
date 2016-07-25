require 'rails_helper'

feature 'change state' do
  before :all do
    @user = create(:user, email: 'admin@admin.com', password: '123456')
    @user.add_role 'admin'

    login
  end
  scenario 'create initiative' do
    initiative = create(:initiative, aasm_state: 'pending_approval', user_id: @user.id)

    visit pending_approval_initiatives_path(initiative)

    expect(page).to have_content(initiative.title)

    click_link 'Підтвердити'

    expect(page).not_to have_content(initiative.title)
  end
end
