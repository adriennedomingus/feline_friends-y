require "rails_helper"

RSpec.feature "user checks out" do
  scenario "visitor attempts to checkout and is redirected to sign-in page" do
    cat = create_cat
    user = create_users[:user1]

    visit cats_path

    click_on "Add to Cart"

    visit "/cart"
    expect(page).to have_content(cat.name)

    select "2016", from: "order_start_date_1i"
    select "November", from: "order_start_date_2i"
    select "11", from: "order_start_date_3i"

    select "2016", from: "order_end_date_1i"
    select "November", from: "order_end_date_2i"
    select "18", from: "order_end_date_3i"

    click_on "Checkout"
    expect(page).to have_content("Please log in")

    log_in_user(user)

    visit "/cart"

    select "2016", from: "order_start_date_1i"
    select "November", from: "order_start_date_2i"
    select "11", from: "order_start_date_3i"

    select "2016", from: "order_end_date_1i"
    select "November", from: "order_end_date_2i"
    select "18", from: "order_end_date_3i"

    click_on "Checkout"

    expect(current_path).to eq("/orders")
    expect(page).to have_content("Order was successfully placed")

    within(".order_table") do
      expect(page).to have_content(Order.last.id)
    end
  end

  scenario "logged in user cannot check out unless they have item in cart" do
    user = create_users[:user1]

    visit login_path

    log_in_user(user)

    visit "/cart"

    select "2016", from: "order_start_date_1i"
    select "November", from: "order_start_date_2i"
    select "11", from: "order_start_date_3i"

    select "2016", from: "order_end_date_1i"
    select "November", from: "order_end_date_2i"
    select "18", from: "order_end_date_3i"

    click_on "Checkout"

    within(".flash") do
      expect(page).to have_content("Your cart is empty")
    end

    expect(current_path).to eq(cart_path)
  end
end
