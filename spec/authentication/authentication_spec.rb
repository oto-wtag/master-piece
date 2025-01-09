require 'rails_helper'

RSpec.feature "Authentication", type: :feature do
  scenario "User signs up, validates fields, and logs in successfully" do
    visit root_path
    click_link "Sign Up"

    # Ensure the signup page is rendered
    expect(page).to have_current_path(new_user_registration_path)
    expect(page).to have_content("Sign Up")

    # Validate fields
    expect(page).to have_field("Name")
    expect(page).to have_field("Email")
    expect(page).to have_field("Password")
    expect(page).to have_field("Password confirmation")

    # Fill out the signup form
    fill_in "Name", with: "Test User"
    fill_in "Email", with: "testuser@example.com"
    fill_in "Password", with: "password123"
    fill_in "Password confirmation", with: "password123"

    # Submit the signup form
    click_button "Sign Up"

    # Expect the signup to be successful
    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_current_path(root_path)

    # Log out after signup
    click_link "Sign Out"
    expect(page).to have_content("Signed out successfully.")

    # Log in with the new credentials
    click_link "Sign In"
    expect(page).to have_current_path(new_user_session_path)
    fill_in "Email", with: "testuser@example.com"
    fill_in "Password", with: "password123"
    click_button "Log In"

    # Expect the login to be successful
    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_current_path(root_path)
  end
end
