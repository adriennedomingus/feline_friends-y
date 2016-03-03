require "rails_helper"

RSpec.feature "user checks out" do
  scenario "logged in user with items in their cart checks out" do
    cat = create_cat
    user = create_users[:user1]

    visit cats_path

    click_on "Add to Cart"

    visit "/cart"
    expect(page).to have_content(cat.name)

    click_on "Checkout"
    expect(page).to have_content("Please log in")

    fill_in "Username", with: user.username
    fill_in "Password", with: "password"

    click_on "Login Meow!"

    visit "/cart"
    click_on "Checkout"

    expect(current_path).to eq("/orders")
    expect(page).to have_content("Order was successfully placed")

    within(".order_table") do
      expect(page).to have_content(Order.last.id)
    end
  end
end
