require "rails_helper"

RSpec.feature "view past orders in order index" do
  scenario "they view the past orders" do
    user, order, cat = create_integration

    admin = create_admin

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    expect(page).to have_content(user.orders.first.id)
    click_on "Order id: #{order.id}"

    within(".order_info") do
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.format_address)
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
end
