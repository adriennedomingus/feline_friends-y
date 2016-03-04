require "rails_helper"

RSpec.feature "admin views all orders" do
  scenario "logged in admin views all orders" do
    order1, order2, order3, order4 = create_user_orders

    admin = create_admin

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    within('.rented_cats') do
      expect(page).to have_content("Order id: #{order1.id}")#rented-0, return-1, cancel2
    end

    within('.returned_cats') do
      expect(page).to have_content("Order id: #{order2.id}")
    end

    within('.cancelled_cats') do
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

    within('.rented_cats') do
      expect(page).to have_content("Order id: #{order1.id}")#rented-0, return-1, cancel2
    end

    within('.returned_cats') do
      expect(page).to have_content("Order id: #{order2.id}")
    end

    within('.cancelled_cats') do
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

    within('.rented_cats') do
      expect(page).to have_content("Order id: #{order1.id}")#rented-0, return-1, cancel2
    end

    within('.returned_cats') do
      expect(page).to have_content("Order id: #{order2.id}")
    end

    within('.cancelled_cats') do
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

    within('.rented_cats') do
      expect(page).to have_content("Order id: #{order1.id}")#rented-0, return-1, cancel2
    end

    within('.returned_cats') do
      expect(page).to have_content("Order id: #{order2.id}")
    end

    within('.cancelled_cats') do
      expect(page).to have_content("Order id: #{order3.id}")
      expect(page).to have_content("Order id: #{order4.id}")
    end

    click_on "Cancel"

    within('.cancelled_cats') do
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

    within('.rented_cats') do
      expect(page).to have_content("Order id: #{order1.id}")#rented-0, return-1, cancel2
    end

    within('.returned_cats') do
      expect(page).to have_content("Order id: #{order2.id}")
    end

    within('.cancelled_cats') do
      expect(page).to have_content("Order id: #{order3.id}")
      expect(page).to have_content("Order id: #{order4.id}")
    end

    click_on "Return"

    within('.returned_cats') do
      expect(page).to have_content("Order id: #{order2.id}")
      expect(page).to have_content("Order id: #{order1.id}")#rented-0, return-1, cancel2
    end
  end
end



# As an Admin
#       When I visit the dashboard
#       Then I can see a listing of all orders
#       And I can see the total number of orders for each status ("Ordered", "Paid", "Cancelled", "Completed")
#       And I can see a link for each individual order
#       And I can filter orders to display by each status type  ("Ordered", "Paid", "Cancelled", "Completed")
#       And I have links to transition the status
#         - I can click on "cancel" on individual orders which are "rented"
#return a rented
#         - I can click on "mark as paid" on orders that are "ordered"
#         - I can click on "mark as completed" on orders that are "paid"
