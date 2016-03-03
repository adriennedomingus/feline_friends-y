require "rails_helper"

RSpec.feature "unauthenticated user security" do
  scenario "unauthenticated user cannot view cart contents of another user" do
    user, order, _ = create_integration
    user_order_id = user.orders.first.id

    visit "/orders"

    expect(current_path).to eq(login_path)
    expect(page).to_not have_content(user.name)
    expect(page).to_not have_content("Order id: #{user_order_id}")
  end

  scenario "unauthenticated user cannot view administrator screens" do
    # visit "/admin/dashboard"

    # expect(page).to have_content("404")

    visit new_user_path

    fill_in "Username", with: "adrienne"
    fill_in "Password", with: "password"
    fill_in "Name", with: "Adrienne"
    click_on "Sign Up"

    save_and_open_page
  end
end


# Background: An unauthenticated user and their abilities
#       As an Unuthenticated User
#       I cannot view another user's private data, such as current order, etc.
#       I should be redirected to login when I try to check out.
#       I cannot view the administrator screens or use administrator functionality.
#       I cannot make myself an administrator.
