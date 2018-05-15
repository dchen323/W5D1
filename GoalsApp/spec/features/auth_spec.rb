require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    expect(page).to have_content("Sign Up")
  end

  scenario 'has username/password fill ins' do
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
  end

  feature 'signing up a user' do

    scenario 'shows username on the homepage after signup' do
      fill_in 'Username', with: 'username1'
      fill_in 'Password', with: 'password'
      click_button "Sign Up"
      expect(page).to have_content('username1')
      expect(current_url).to eq(user_url(User.find_by_username('username1')))
  end
end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    fill_in 'Username', with: 'username1'
    fill_in 'Password', with: 'password'
    click_button "Sign Up"
    click_button "Sign Out"
    expect(page).not_to have_content('username1')
  end
  end

end
