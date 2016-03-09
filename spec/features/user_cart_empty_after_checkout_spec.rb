require "rails_helper"

RSpec.feature "User cart is empty after checkout", js: true do
  scenario "views cart is empty" do
    user = create_users[:user1]
    visit login_path

    log_in_user(user)
    create_cat

    visit cats_path

    click_on "Add to Cart"

    visit "/cart"

    page.execute_script("$('#start').val('11 November, 2016')")
    page.execute_script("$('#end').val('17 November, 2016')")

    click_on "Checkout"

    visit cart_path

    page.execute_script("$('#start').val('11 November, 2016')")
    page.execute_script("$('#end').val('17 November, 2016')")

    click_on "Checkout"

    expect(page).to have_content "Your cart is empty"
  end
end
