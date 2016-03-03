require "rails_helper"

RSpec.feature "user views all past orders" do
  scenario "user views all past orders only associated with their account" do
    user1 = create_users[:user1]
    user2 = create_users[:user2]

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user1)

    order_1 = user1.orders.create(status: 0)
    order_2 = user1.orders.create(status: 0)
    order_3 = user2.orders.create(status: 0)

    visit "/orders"

    within(".collection") do
      expect(page).to have_content(order_1.id)
      expect(page).to have_content(order_2.id)
      expect(page).to_not have_content(order_3.id)
    end
  end

  scenario "logged out user is redirected to sign in when they view /orders" do
    visit "/orders"

    expect(current_path).to eq(login_path)
  end

  scenario "logged in user views empty order page" do
    user1 = create_users[:user1]

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user1)

    visit "/orders"

    within(".collection") do
      expect(page).to have_content("No order history")
    end
  end
end
