require "rails_helper"

RSpec.feature "unauthenticated user security" do
  scenario "unauthenticated user cannot view cart contents of another user" do
    user, = create_integration
    user_order_id = user.orders.first.id

    visit "/orders"

    expect(current_path).to eq(login_path)
    expect(page).to_not have_content(user.name)
    expect(page).to_not have_content("Order id: #{user_order_id}")
  end

  scenario "unauthenticated user cannot view admin dashboard or
           make themselves an admin" do
    visit admin_dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist")

    visit new_user_path

    fill_in "Username", with: "adrienne"
    fill_in "Password", with: "password"
    fill_in "Name", with: "Adrienne"
    click_on "Sign Up"

    visit admin_dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end
