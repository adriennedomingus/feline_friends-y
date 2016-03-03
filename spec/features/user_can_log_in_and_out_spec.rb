require "rails_helper"

RSpec.feature "user can log in and out" do
  scenario "user logs in and sees user dashboard" do
    create_users[:user1]

    visit root_path
    within(".hide-on-med-and-down") do
      click_on "Login"
    end

    expect(current_path).to eq(login_path)

    fill_in "Username", with: "adrienne"
    fill_in "Password", with: "password"

    click_on "Login Meow!"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("adrienne")
  end

  scenario "user can log out" do
    create_users[:user1]

    visit root_path
    within(".hide-on-med-and-down") do
      click_on "Login"
    end
    fill_in "Username", with: "adrienne"
    fill_in "Password", with: "password"

    click_on "Login Meow!"
    within(".hide-on-med-and-down") do
      click_on "Logout"
    end
    expect(page).to have_content("Login")
    expect(page).to_not have_content("Logout")
  end
end
