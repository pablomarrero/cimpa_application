require 'spec_helper'

feature 'User management' do

  scenario "create new account" do
    visit root_path

    expect{
      click_link 'Login'
      click_link 'Sign up'
      fill_in 'Email', with: 'newuser@example.com'
      fill_in 'Password', with: 'secret123'
      fill_in 'Password confirmation', with: 'secret123'
      click_button 'Sign Up'
    }.to change(User, :count).by(1)

    expect(current_path).to eq root_path
    expect(page).to have_content 'newuser@example.com'
    within 'div.navbar-inner' do
      expect(page).to have_content 'People'
    end 
  end

end
