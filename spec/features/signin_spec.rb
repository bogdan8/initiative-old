require 'rails_helper'

feature 'signing in' do
  let(:user) { FactoryGirl.create(:user, email: Faker::Internet.email, password: Devise.friendly_token.first(8)) }

  def fill_in_signin_fields
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Війти'
  end

  scenario '#visiting the site to sign in' do
    visit root_path
    click_link 'ВХІД'
    fill_in_signin_fields
    expect(page).to have_content 'Ви увійшли в систему.'
  end
end
