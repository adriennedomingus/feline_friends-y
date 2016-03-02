require "rails_helper"

RSpec.feature "view past orders in order index" do
  scenario "they view the past orders" do
    user, order, cat = create_integration

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit "/orders"

    expect(page).to have_content(user.orders.first.id)

    click_on "Order id: #{order.id}"

    expect(page).to have_content(cat.name)
    expect(page).to have_content(cat.format_price)
    expect(page).to have_link(cat.name, href: cat_path(cat))
    expect(page).to have_content(order.status)
    expect(page).to have_content(order.total)
    expect(page).to have_content(order.placed_at)

    # Background: An existing user that has one previous order
    #   As an authenticated user
    #   When I visit "/orders"
    #   Then I should see my past order
    #   And I should see a link to view that order
    #   And when I click that link
    #   Then I should see each item that was order with the quantity and line-item subtotals
    #   And I should see links to each item's show page
    #   And I should see the current status of the order (ordered, paid, cancelled, completed)
    #   And I should see the total price for the order
    #   And I should see the date/time that the order was submitted
  end

  # scenario "returned and completed orderrs show action time" do
  #   user, order, _, _ = create_integration
  #
  # allow_any_instance_of(ApplicationController).
    # to receive(:current_user).and_return(user)

  #   visit "/orders"
  #   click_on "Order id: #{order.id}"
  #   #add cancelled at and returned at columns to order
  #   expect(page).to have_content(order.cancelled_at)
  # end

  scenario "retired items still have view page but no add to cart button" do
    user, order, cat1 = create_integration

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit "/orders"
    click_on "Order id: #{order.id}"
    click_on cat1.name
    expect(current_path).to eq(cat_path(cat1))
    expect(page).to_not have_button("Add to Cart")
  end
end
