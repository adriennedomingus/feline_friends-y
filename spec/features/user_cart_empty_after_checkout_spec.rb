require "rails_helper"

RSpec.feature "User cart is empty after checkout" do
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

    select "2016", from: "order_start_date_1i"
    select "November", from: "order_start_date_2i"
    select "11", from: "order_start_date_3i"

    select "2016", from: "order_end_date_1i"
    select "November", from: "order_end_date_2i"
    select "18", from: "order_end_date_3i"

    click_on "Checkout"

    within(".hide-on-med-and-down") do
      expect(page).to have_content "Cart: 0"
      click_on "Cart: 0"
    end

    click_on "Checkout"

    expect(page).to have_content "Your cart is empty"
  end
end
