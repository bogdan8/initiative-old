require 'rails_helper'

feature 'change state' do
  before :all do
    user = create(:user)
    user.add_role 'admin'

    login
  end
  scenario 'create initiative' do
    initiative = create(:initiative, aasm_state: 'pending_approval')

    visit pending_approval_initiatives_path(initiative)

    expect(page).to have_content(initiative.title)

    click_link 'Підтвердити'

    expect(page).not_to have_content(initiative.title)
  end
end
