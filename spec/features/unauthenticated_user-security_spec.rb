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

  scenario "unauthenticated user is " do

  end
end


# Background: An unauthenticated user and their abilities
#       As an Unuthenticated User
#       I cannot view another user's private data, such as current order, etc.
#       I should be redirected to login when I try to check out.
#       I cannot view the administrator screens or use administrator functionality.
#       I cannot make myself an administrator.
