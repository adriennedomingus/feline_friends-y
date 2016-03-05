require "rails_helper"

RSpec.feature "admin views all orders" do
  scenario "logged in admin views all orders" do
    order1, order2, order3, order4 = create_user_orders

    admin = create_admin

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    within('#rented_cats') do
      expect(page).to have_content("Order id: #{order1.id}")
    end

    within('#returned_cats') do
      expect(page).to have_content("Order id: #{order2.id}")
    end

    within('#cancelled_cats') do
      expect(page).to have_content("Order id: #{order3.id}")
      expect(page).to have_content("Order id: #{order4.id}")
    end
  end

  scenario "logged in admin views all orders" do
    order1, order2, order3, order4 = create_user_orders

    admin = create_admin

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    within('#rented_cats') do
      expect(page).to have_content("Order id: #{order1.id}")
    end

    within('#returned_cats') do
      expect(page).to have_content("Order id: #{order2.id}")
    end

    within('#cancelled_cats') do
      expect(page).to have_content("Order id: #{order3.id}")
      expect(page).to have_content("Order id: #{order4.id}")
    end
  end

  scenario "logged in admin views all orders" do
    order1, order2, order3, order4 = create_user_orders

    admin = create_admin

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    within('#rented_cats') do
      expect(page).to have_content("Order id: #{order1.id}")
    end

    within('#returned_cats') do
      expect(page).to have_content("Order id: #{order2.id}")
    end

    within('#cancelled_cats') do
      expect(page).to have_content("Order id: #{order3.id}")
      expect(page).to have_content("Order id: #{order4.id}")
    end
  end

  scenario "logged in admin cancelled rented cat" do
    order1, order2, order3, order4 = create_user_orders

    admin = create_admin

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    within('#rented_cats') do
      expect(page).to have_content("Order id: #{order1.id}")
    end

    within('#returned_cats') do
      expect(page).to have_content("Order id: #{order2.id}")
    end

    within('#cancelled_cats') do
      expect(page).to have_content("Order id: #{order3.id}")
      expect(page).to have_content("Order id: #{order4.id}")
    end

    click_on "Cancel"

    within('#cancelled_cats') do
      expect(page).to have_content("Order id: #{order3.id}")
      expect(page).to have_content("Order id: #{order4.id}")
      expect(page).to have_content("Order id: #{order1.id}")
    end
  end

  scenario "logged in admin return rented cat" do
    order1, order2, order3, order4 = create_user_orders

    admin = create_admin

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    within('#rented_cats') do
      expect(page).to have_content("Order id: #{order1.id}")
    end

    within('#returned_cats') do
      expect(page).to have_content("Order id: #{order2.id}")
    end

    within('#cancelled_cats') do
      expect(page).to have_content("Order id: #{order3.id}")
      expect(page).to have_content("Order id: #{order4.id}")
    end

    click_on "Return"

    within('#returned_cats') do
      expect(page).to have_content("Order id: #{order2.id}")
      expect(page).to have_content("Order id: #{order1.id}")
    end
  end
end
