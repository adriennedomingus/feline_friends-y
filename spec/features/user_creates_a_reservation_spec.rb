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

    select "2016", from: "order_end_date_1i"
    select "November", from: "order_end_date_2i"
    select "17", from: "order_end_date_3i"
    click_on "Checkout"
    expect(current_path).to eq("/orders")
    expect(page).to have_content("Order was successfully placed")

    visit order_path(Order.last)
    within(".rental_period") do
      expect(page).to have_content("Nov 11, 2016")
      expect(page).to have_content("Nov 17, 2016")
    end

    expect(page).to have_content("$120.00")
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

    select "2016", from: "order_end_date_1i"
    select "November", from: "order_end_date_2i"
    select "18", from: "order_end_date_3i"

    click_on "Checkout"

    visit cats_path

    click_on "Add to Cart"

    visit "/cart"
    select "2016", from: "order_start_date_1i"
    select "November", from: "order_start_date_2i"
    select "11", from: "order_start_date_3i"

    select "2016", from: "order_end_date_1i"
    select "November", from: "order_end_date_2i"
    select "18", from: "order_end_date_3i"

    click_on "Checkout"

    message = "One of the cats in your order is already reserved on that date."
    expect(page).to have_content(message)
  end

  scenario "order end date must be after start date" do
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

    select "2016", from: "order_end_date_1i"
    select "November", from: "order_end_date_2i"
    select "11", from: "order_end_date_3i"

    click_on "Checkout"

    expect(current_path).to eq("/cart")
    expect(page).to have_content
      "Your reservation must end at least one day after your start date"
  end

  scenario "start date must be today or after" do
    create_cat
    user = create_users[:user1]
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit cats_path

    click_on "Add to Cart"

    visit "/cart"
    select "2016", from: "order_start_date_1i"
    select "March", from: "order_start_date_2i"
    select "6", from: "order_start_date_3i"

    select "2016", from: "order_end_date_1i"
    select "November", from: "order_end_date_2i"
    select "11", from: "order_end_date_3i"

    click_on "Checkout"

    expect(current_path).to eq("/cart")
    expect(page).to have_content
      "You cannot make a reservation in the past"
  end
end
