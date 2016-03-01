require "rails_helper"

RSpec.feature "visitor creates account" do
  scenario "user still has items in cart" do
    c1 = Category.create(name: "Fluffy")
    path = "http://www.altpress.com/images/uploads/news/Hello_Kißtty.jpg"
    cat1 = c1.cats.create(
      name: "Fido",
      age: 2,
      description: "Actually a dog",
      image: path,
      price: 2000)

    visit cats_path
    click_on "Add to Cart"

    visit "/"

    expect(page).to have_content("Login")
    click_on("Create Account")
    fill_in "Username", with: "adrienne"
    fill_in "Password", with: "password"
    fill_in "Name", with: "Adrienne"
    click_on "Sign Up"

    expect(current_path).to eq(dashboard_path)

    within(".nav-wrapper") do
      expect(page).to have_content("Logged in as adrienne")
      expect(page).to have_content("Log Out")
      expect(page).to_not have_content("Log In")
    end

    expect(page).to have_content("Your Orders")
    expect(page).to have_content("Name: Adrienne")
    click_on "Cart"

    expect(page).to have_content(cat1.name)
  end
end
