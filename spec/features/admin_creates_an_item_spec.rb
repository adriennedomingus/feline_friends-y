require "rails_helper"

RSpec.feature "admin creates an item" do
  scenario "the item can be seen on the cat index" do
    admin = create_admin
    Category.create(name: "Fluffy")
    Category.create(name: "Mean")

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)

    visit new_admin_cat_path
    fill_in "Name", with: "Mena"
    fill_in "Price", with: "4500"
    fill_in "Description", with: "Describing a cat"
    fill_in "Age", with: "4"
    fill_in "Image", with: "http://41.media.tumblr.com/3f823cc08d835fb399eaa315d268b2b0/tumblr_ni7labrSS91qji3sdo1_500.jpg"
    select "Fluffy", from: "cat[category_id]"
    click_on "Create Cat"
    expect(page).to have_content("You have added Mena to the site!")
  end

  scenario "there is a default image when none is added" do
    admin = create_admin
    Category.create(name: "Fluffy")
    Category.create(name: "Mean")

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)

    visit new_admin_cat_path
    fill_in "Name", with: "Mena"
    fill_in "Price", with: "4500"
    fill_in "Description", with: "Describing a cat"
    fill_in "Age", with: "4"
    select "Fluffy", from: "cat[category_id]"
    click_on "Create Cat"

    expect(page).to have_content("You have added Mena to the site!")
  end

  scenario "invalid params" do
    admin = create_admin
    Category.create(name: "Fluffy")
    Category.create(name: "Mean")

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)

    visit new_admin_cat_path
    fill_in "Name", with: "Mena"
    fill_in "Price", with: "4500"
    fill_in "Age", with: "4"
    select "Fluffy", from: "cat[category_id]"
    click_on "Create Cat"

    expect(page).to have_content("Please enter all information")
  end
end
