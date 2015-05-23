require 'spec_helper'

describe "Logging in" do
  it "logs the user in and go to the todo list" do
    User.create(
        first_name: "Tim",
        last_name: "Cook",
        email: "stevejobs@apple.com",
        password: "hello1234",
        password_confirmation: "hello1234"
    )

    visit new_user_session_path

    fill_in "Email Address", with: "stevejobs@apple.com"
    fill_in "Password", with: "hello1234"

    click_button "Log In"

    expect(page).to have_content("Todo Lists")
    expect(page).to have_content("Thanks for logging in!")
  end

  it "displays the email address in the event of a failed login" do
    visit new_user_session_path

    fill_in "Email Address", with: "sjobs@apple.com"
    fill_in "Password", with: "incorrect"

    click_button "Log In"

    expect(page).to have_content("Please check your email and password")
    expect(page).to have_field("Email Address", with: "sjobs@apple.com")
  end
end