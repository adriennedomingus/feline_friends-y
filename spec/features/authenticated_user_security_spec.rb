require "rails_helper"

RSpec.feature "authenticated user security" do
  scenario "authenticated user cannot view profile
           or cart contents of another user" do
    user1 = create_users[:user2]

    visit login_path
    log_in_user(user1)

    user2, = create_integration

    user2_order_id = user2.orders.first.id

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(user1.name)
    expect(page).to_not have_content(user2.name)

    visit "/orders"
    expect(page).to have_content("No order history")
    expect(page).to_not have_content(user2.name)
    expect(page).to_not have_content("Order id: #{user2_order_id}")
  end

  scenario "authenticated user cannot view admin dashboard" do
    user = create_users[:user1]

    visit login_path
    log_in_user(user)

    visit admin_dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end
