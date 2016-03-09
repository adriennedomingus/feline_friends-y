require "rails_helper"

RSpec.feature "user checks out" do
  scenario "visitor tries to checkout is redirected to sign-in", js: true do
    cat = create_cat
    user = create_users[:user1]

    visit cats_path

    click_on "Add to Cart"

    visit "/cart"
    expect(page).to have_content(cat.name)

    page.execute_script("$('#start').val('05 November, 2016')")
    page.execute_script("$('#end').val('07 November, 2016')")

    click_on "Checkout"
    expect(page).to have_content("Please log in")

    log_in_user(user)

    visit "/cart"

    page.execute_script("$('#start').val('05 November, 2016')")
    page.execute_script("$('#end').val('07 November, 2016')")

    click_on "Checkout"

    expect(current_path).to eq("/orders")
    expect(page).to have_content("Order was successfully placed")

    within(".order_table") do
      expect(page).to have_content(Order.last.id)
    end
  end

  scenario "logged in user cannot check out unless with empty cart", js: true do
    user = create_users[:user1]

    visit login_path

    log_in_user(user)

    visit "/cart"

    page.execute_script("$('#start').val('05 November, 2016')")
    page.execute_script("$('#end').val('07 November, 2016')")

    click_on "Checkout"

    within(".flash") do
      expect(page).to have_content("Your cart is empty")
    end

    expect(current_path).to eq(cart_path)
  end
end
