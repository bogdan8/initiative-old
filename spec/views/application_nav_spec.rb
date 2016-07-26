require 'spec_helper'

feature 'style navbar' do
  scenario 'if change style in open another menu' do
    visit root_path
    click_link 'ВХІД'

    page.has_css?('button.navbar-brand.navbar-a-home')
  end

  scenario 'if change style in open menu with style' do
    visit root_path
    click_link 'головна'

    page.has_css?('button.navbar-brand.navbar-a-home.navbar-a-chose')
  end
end
