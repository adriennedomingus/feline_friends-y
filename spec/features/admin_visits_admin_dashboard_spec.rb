require "rails_helper"

RSpec.feature "admin user dashboard" do
  scenario "admin sees admin dashboard" do
    admin = create_admin

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)
    visit admin_dashboard_path

    expect(page).to have_content("Admin Dashboard")
  end

  scenario "registered default user cannot visit admin dashboard" do
    user = create_users[0]
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)
    visit admin_dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist")
  end

  scenario "unregistered user cannot visit admin dashboard" do
    visit admin_dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end
