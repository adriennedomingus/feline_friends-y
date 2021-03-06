require "rails_helper"

RSpec.feature "view past orders in order index" do
  scenario "they view the past orders" do
    user, order, cat = create_integration

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit "/orders"

    expect(page).to have_content(user.orders.first.id)

    click_on "Order id: #{order.id}"

    within(".order_info") do
      expect(page).to have_content(order.status)
      expect(page).to have_content(order.total)
      expect(page).to have_content(order.format_time(order.created_at))
    end

    within(".cat_info") do
      expect(page).to have_content(cat.name)
      expect(page).to have_content(cat.format_price)
      expect(page).to have_link(cat.name, href: cat_path(cat))
    end
  end

  scenario "returned and completed orders show action time" do
    user = create_users[:user1]
    order = Order.create(status: 1,
                         cancelled_at: "2016-03-02 11:10:57 -0700")
    cat = Cat.create(
      name: "Chica",
      age: 2,
      description: "Actually a dog",
      image: image_path,
      price: 2000,
      category_id: categories[0].id,
      status: "inactive")
    cat2 = Cat.create(
      name: "Caia",
      age: 8,
      description: "Chelsea's other cat",
      image: image_path,
      price: 3000,
      category_id: categories[0].id,
      status: "active")
    CatOrder.create(order_id: order.id, cat_id: cat.id)
    CatOrder.create(order_id: order.id, cat_id: cat2.id)
    user.orders << order


    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit "/orders"
    click_on "Order id: #{order.id}"

    within(".order_info") do
      expect(page).to have_content(order.format_time(order.cancelled_at))
    end
  end

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
