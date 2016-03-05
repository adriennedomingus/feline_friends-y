require "rails_helper"

RSpec.feature "User can view dashboard" do
  scenario "views dashboard using nav link" do
    user = create_users[:user1]
    visit "/"
    within(".hide-on-med-and-down") do
      click_on "Login"
    end
    log_in_user(user)

    within(".hide-on-med-and-down") do
      click_on("Logged in as #{user.username}")
    end

    expect(page).to have_content "Name: #{user.name}"
  end
end
