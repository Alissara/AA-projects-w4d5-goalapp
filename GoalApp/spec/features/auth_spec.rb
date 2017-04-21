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
  subject(:user) { User.create(username: 'joe', password: 'password') }
  # lazy!!!
  scenario "shows username on the homepage after login" do
    visit new_session_url
    fill_in 'username', with: user.username
    fill_in 'password', with: 'password'
    click_on 'Sign In'
    # at bob's page
    click_on 'All Users'

    expect(page).to have_content("Logged in as: joe")
  end
end

feature "logging out" do
  scenario "begins with a logged out state" do
    visit users_url
    expect(page).to_not have_content("Logged in as:")
  end

  scenario "doesn't show username on the homepage after logout" do
    visit users_url
    click_on 'Sign up!'
    fill_in 'username', with: 'john'
    fill_in 'password', with: 'password'
    click_on 'Sign Up'
    click_on 'Log out!'
    expect(page).to have_content("All the Users!")
    expect(page).to_not have_content("Logged in as:")
  end

end
