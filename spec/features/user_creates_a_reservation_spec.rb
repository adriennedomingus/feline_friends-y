require "rails_helper"

RSpec.feature "user creates a reservation" do
  scenario "user creates a reservation" do
    create_cat
    user = create_users[:user1]
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit cats_path

    click_on "Add to Cart"

    visit "/cart"
    select "2016", from: "order_start_date_1i"
    select "November", from: "order_start_date_2i"
    select "11", from: "order_start_date_3i"

    click_on "Checkout"

    expect(current_path).to eq("/orders")
    expect(page).to have_content("Order was successfully placed")

    visit order_path(Order.last)
    within(".rental_period") do
      expect(page).to have_content("Nov 11, 2016")
    end
  end

  scenario "user cannot make a reservation at same time cat is reserved" do
    create_cat
    user = create_users[:user1]
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit cats_path

    click_on "Add to Cart"

    visit "/cart"
    select "2016", from: "order_start_date_1i"
    select "November", from: "order_start_date_2i"
    select "11", from: "order_start_date_3i"

    click_on "Checkout"

    visit cats_path

    click_on "Add to Cart"

    visit "/cart"
    select "2016", from: "order_start_date_1i"
    select "November", from: "order_start_date_2i"
    select "11", from: "order_start_date_3i"

    click_on "Checkout"

    expect(page).to have_content
      ("One of the cats in your order is already reserved on that date.")
  end
end
