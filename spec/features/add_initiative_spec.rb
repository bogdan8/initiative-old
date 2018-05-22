require 'rails_helper'
feature '#adding initiatives' do
  scenario '#allow a user to add a initiative' do
    initiative = create(:initiative)

    visit initiative_path(initiative)

    expect(page).to have_content(initiative.title)
  end
end
