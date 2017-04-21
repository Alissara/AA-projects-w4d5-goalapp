require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content('Sign Up')
  end

  feature "signing up a user" do
    # fill out form
    before(:each) do
      visit new_user_url
      fill_in 'username', with: 'bob'
      fill_in 'password', with: 'password'
      click_on 'Sign Up'
    end

    scenario "redirects to users page after signup" do
      expect(page).to have_content("bob")
    end

    scenario "shows username on the homepage after signup" do
      visit users_url
      expect(page).to have_content("bob")
    end
  end
end

feature "logging in" do
  scenario "shows username on the homepage after login" do

  end
end

feature "logging out" do

  scenario "begins with a logged out state"

  scenario "doesn't show username on the homepage after logout"

end
