require "rails_helper"

RSpec.feature "User can view orders" do
  scenario "views orders using nav link" do
    user = create_users[:user1]
    visit "/"
    within(".hide-on-med-and-down") do
      click_on "Login"
    end
    log_in_user(user)

    within(".hide-on-med-and-down") do
      click_on("Orders")
    end

    expect(page).to have_content "Your Orders"
  end
end
