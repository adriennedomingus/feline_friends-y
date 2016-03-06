require "rails_helper"

RSpec.feature "admin edits an item" do
  scenario "admin edits an item with valid params" do
    admin = create_admin

    cat = create_cat

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)

    visit cat_path(cat)

    expect(page).to have_content("Fido")

    click_on "Edit Fido"

    fill_in "Name", with: "Kitteh"
    fill_in "Price", with: "4500"
    fill_in "Description", with: "She's so sweet and cuddly"
    fill_in "Age", with: "10"
    fill_in "Image", with: "http://41.media.tumblr.com/3f823cc08d835fb399eaa315d268b2b0/tumblr_ni7labrSS91qji3sdo1_500.jpg"
    select "Fluffy", from: "cat[category_id]"
    click_on "Update Cat"

    within(".flash") do
      expect(page).to have_content("You have edited Kitteh!")
    end

    within(".all_cats") do
      expect(page).to have_content("Kitteh")
    end
  end
  scenario "admin edits an item with invalid params" do
    admin = create_admin

    cat = create_cat

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)

    visit cat_path(cat)

    visit edit_admin_cat_path(cat)

    fill_in "Name", with: ""
    fill_in "Price", with: "4500"
    fill_in "Description", with: "She's so sweet and cuddly"
    fill_in "Age", with: "10"
    fill_in "Image", with: "http://41.media.tumblr.com/3f823cc08d835fb399eaa315d268b2b0/tumblr_ni7labrSS91qji3sdo1_500.jpg"
    select "Fluffy", from: "cat[category_id]"
    click_on "Update Cat"

    within(".flash") do
      expect(page).to have_content("Please enter all information")
    end
  end

  scenario "user cannot edit a cat" do
    user = create_users[:user1]

    cat = create_cat

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit cat_path(cat)

    expect(page).to_not have_content("Edit #{cat.name}")
  end
end
