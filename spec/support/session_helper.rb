def create_an_account
  visit new_user_registration_path

  fill_in 'user_email', with: 'user@user.com'
  fill_in 'user_password', with: '123456'
  fill_in 'user_password_confirmation', with: '123456'

  click_button 'Зареєструватись'
end

def login
  visit new_user_session_path

  fill_in 'user_email', with: 'user@user.com'
  fill_in 'user_password', with: '123456'

  click_button 'Війти'
end
