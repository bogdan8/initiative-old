require 'rails_helper'

feature 'visit initiatives pages' do
  scenario 'allow a user to add a initiative and visit in initiatives pages' do
    initiative = create(:initiative)

    visit initiatives_path

    expect(page).to have_content(initiative.title)
  end
end
