require "rails_helper"

RSpec.feature "User cart is empty after checkout", js: true do
  scenario "views cart is empty" do
    user = create_users[:user1]
    visit "/"
    within(".hide-on-med-and-down") do
      click_on "Login"
    end
    log_in_user(user)
    create_cat

    visit cats_path

    click_on "Add to Cart"

    within(".hide-on-med-and-down") do
      click_on "Cart: 1"
    end
    page.execute_script("$('#start').val('05 November, 2016')")
    page.execute_script("$('#end').val('07 November, 2016')")

    click_on "Checkout"

    within(".hide-on-med-and-down") do
      expect(page).to have_content "Cart: 0"
      click_on "Cart: 0"
    end

    click_on "Checkout"

    expect(page).to have_content "Your cart is empty"
  end
end
