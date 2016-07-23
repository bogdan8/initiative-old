def login
  visit new_user_session_path
  within('#new_user') do
    fill_in 'user_email', with: 'admin@admin.com'
    fill_in 'user_password', with: '123456'
  end
  click_button 'Війти'
end
