require 'rails_helper'

feature 'Admin sign_in' do
  before :each do
    user = User.create(email: 'admin@admin.com', password: '123456',
                       confirmed_at: '2016-07-17 07:35:55.139051',
                       confirmation_sent_at: '2016-07-17 07:35:36.292019')
    user.add_role 'admin'
  end
  scenario 'allows accees to page admins' do
    visit new_user_session_path
    within('#new_user') do
      fill_in 'user_email', with: 'admin@admin.com'
      fill_in 'user_password', with: '123456'
    end
    click_button 'Війти'
    expect(page).to have_content 'AdminLTE'
  end
end
