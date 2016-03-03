require "rails_helper"

RSpec.feature "admin logs in" do
  scenario "is redirected to admin dashboard" do
    admin = create_admin

    visit "/login"
    fill_in "Username", with: admin.username
    fill_in "Password", with: "password"
    click_on "Login Meow!"

    expect(current_path).to eq("/admin/dashboard")
  end
end
