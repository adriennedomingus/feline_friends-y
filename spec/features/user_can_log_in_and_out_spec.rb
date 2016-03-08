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
    scenario "user attempts to log in without registering" do
      visit root_path
      within(".hide-on-med-and-down") do
        click_on "Login"
      end

      fill_in "Username", with: "adrienne"
      fill_in "Password", with: "password"

      click_on "Login Meow!"

      expect(current_path).to eq(new_user_path)

      within(".flash") do
        expect(page).to have_content("Please register")
      end
    end
  end
end



# when user doesn’t exist… ???? DONE
# cats are always booked. why???
# change name of method in cart to #cats DONE
#@cat.id DONE
# extract create order logic to PORO NEED
# potentially change duplication in sessions controller create action NEED
# look into ActiveRecord transactions for saving user + address at the same time DONE
# singular resource :user for routes instead of embedding id in url for user NEED
# line 29 in admin cats controller passes in self DONE
# admin orders controller update action -- switch to passing actual integer through the params DONE
# admin orders index: @orders.rented, @orders.cancelled, etc, then implement as class methods on order model DONE except for overdue order, had issues
# in cats show at bottom of file, clean up conditional logic- DONE
# each_order partial line 1: change to custom method to ask if user has orders-DONE
