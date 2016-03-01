require "rails_helper"

RSpec.feature "user views all past orders" do
  scenario "user views all past orders" do
    user = User.create(username: "adrienne",
                       password: "password",
                       name: "Adrienne")
    user2 = User.create(username: "chelsea",
                        password: "password",
                        name: "Chelsea")
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    order_1 = user.orders.create
    order_2 = user.orders.create
    order_3 = user2.orders.create

    visit "/orders"

    expect(page).to have_content(order_1.id)
    expect(page).to have_content(order_2.id)
    expect(page).to_not have_content(order_3.id)
  end
end
