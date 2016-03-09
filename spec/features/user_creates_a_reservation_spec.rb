require "rails_helper"

RSpec.feature "user creates a reservation" do
  scenario "user creates a reservation", js: true do
    create_cat
    user = create_users[:user1]
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit cats_path

    click_on "Add to Cart"

    visit "/cart"
    page.execute_script("$('#start').val('11 November, 2016')")
    page.execute_script("$('#end').val('17 November, 2016')")
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

  scenario "user cannot make a reservation while cat is reserved", js: true do
    create_cat
    user = create_users[:user1]
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit cats_path

    click_on "Add to Cart"

    visit "/cart"
    page.execute_script("$('#start').val('2 December, 2017')")
    page.execute_script("$('#end').val('23 December, 2017')")

    click_on "Checkout"

    visit cats_path

    click_on "Add to Cart"

    visit "/cart"
    page.execute_script("$('#start').val('20 December, 2017')")
    page.execute_script("$('#end').val('23 December, 2017')")

    click_on "Checkout"

    message = "One of the cats in your order is already reserved on that date."
    expect(page).to have_content(message)
  end

  scenario "order end date must be after start date", js: true do
    create_cat
    user = create_users[:user1]
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit cats_path

    click_on "Add to Cart"

    visit "/cart"
    page.execute_script("$('#start').val('20 December, 2017')")
    page.execute_script("$('#end').val('19 December, 2017')")


    click_on "Checkout"

    expect(current_path).to eq("/cart")
    expect(page).to have_content
      "Your reservation must end at least one day after your start date"
  end

  scenario "start date must be today or after", js: true do
    create_cat
    user = create_users[:user1]
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit cats_path
    click_on "Add to Cart"

    visit "/cart"
    page.execute_script("$('#start').val('05 March, 2016')")
    page.execute_script("$('#end').val('07 March, 2016')")

    click_on "Checkout"

    expect(current_path).to eq("/cart")
    expect(page).to have_content("You cannot make a reservation in the past")
  end
end
