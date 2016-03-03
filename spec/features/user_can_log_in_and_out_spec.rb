require "rails_helper"

RSpec.feature "user can log in and out" do
  context "valid params" do
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
      user = create_users[:user1]

      visit root_path

      within(".hide-on-med-and-down") do
        click_on "Login"
      end

      log_in_user(user)

      within(".hide-on-med-and-down") do
        click_on "Logout"
      end

      expect(page).to have_content("Login")
      expect(page).to_not have_content("Logout")
    end
  end
  context "invalid params" do
    scenario "user does not provide password and is redirected to login" do
      create_users[:user1]

      visit root_path

      within(".hide-on-med-and-down") do
        click_on "Login"
      end

      fill_in "Username", with: "adrienne"

      click_on "Login Meow!"

      expect(current_path).to eq(login_path)

      within(".flash") do
        expect(page).to have_content("Please enter valid username and password")
      end
    end
  end
end
