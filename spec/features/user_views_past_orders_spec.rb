require "rails_helper"

RSpec.feature "user views all past orders" do
  scenario "user views all past orders" do
    user1 = create_users[:user1]
    user2 = create_users[:user2]

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user1)

    order_1 = user1.orders.create(status: 0)
    order_2 = user1.orders.create(status: 0)
    order_3 = user2.orders.create(status: 0)

    visit "/orders"

    expect(page).to have_content(order_1.id)
    expect(page).to have_content(order_2.id)
    expect(page).to_not have_content(order_3.id)
  end
end
