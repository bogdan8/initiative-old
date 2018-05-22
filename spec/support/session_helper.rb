def login_admin
  @user = create(:user, email: 'admin@admin.com', password: '123456')
  @user.add_role 'admin'
  visit new_user_session_path
  within('#new_user') do
    fill_in 'user_email', with: 'admin@admin.com'
    fill_in 'user_password', with: '123456'
  end
  click_button 'Війти'
end

def login_user
  @request.env['devise.mapping'] = Devise.mappings[:user]
  @user = FactoryGirl.create(:user)
  @user.add_role 'user'
  @user.confirm
  sign_in @user
end
