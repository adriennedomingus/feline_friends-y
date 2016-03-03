require "rails_helper"

RSpec.feature "visitor creates account" do
  context "valid params" do
    scenario "user still has items in cart" do
      cat = create_cat

      visit cats_path
      click_on "Add to Cart"

      visit "/"

      expect(page).to have_content("Login")
      within(".hide-on-med-and-down") do
        click_on("Create Account")
      end

      fill_in "Username", with: "adrienne"
      fill_in "Password", with: "password"
      fill_in "Name", with: "Adrienne"
      click_on "Sign Up"

      User.find_by(username: "adrienne")

      expect(current_path).to eq(dashboard_path)

      within(".nav-wrapper") do
        expect(page).to have_content("Logged in as adrienne")
        expect(page).to have_content("Logout")
        expect(page).to_not have_content("Log In")
      end

      expect(page).to have_content("Your Orders")
      expect(page).to have_content("Name: Adrienne")

      within(".hide-on-med-and-down") do
        click_on "Cart"
      end

      expect(page).to have_content(cat.name)
    end
  end

  context "invalid params" do
    scenario "user does not complete all fields for registration" do
      visit new_user_path

      fill_in "Username", with: "adrienne"
      fill_in "Name", with: "Adrienne"

      click_on "Sign Up"

      expect(current_path).to eq(users_path)

      within(".flash") do
        expect(page).to have_content("Please enter
                                     a valid username and password")
      end
    end
  end
end
