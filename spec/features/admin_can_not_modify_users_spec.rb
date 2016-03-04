require "rails_helper"

RSpec.feature "Admin can not modify users" do
  scenario "Admin will see an error on other users page" do
    admin = create_admin
    user = create_users[:user1]
    visit login_path
    log_in_user(admin)

    visit dashboard_path

    expect(page).to have_content "Name: #{admin.name}"

    click_on "Edit"

    fill_in "Username", with: "addy"
    fill_in "Password", with: "password1"
    fill_in "Name", with: "Abigail"

    click_on "Edit"

    expect(page).to have_content "Name: Abigail"

    visit "/users/#{user.id}/edit"

    expect(page).to have_content "The page you were looking for doesn't exist."
  end
end
