require "rails_helper"

RSpec.feature "admin deletes an item" do
  scenario "admin deletes a cat" do
    admin = create_admin

    cat = create_cat

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)

    visit cat_path(cat)

    within(".all_cats") do
      expect(page).to have_content("Fido")
    end

    click_on "Delete Fido"

    within(".flash") do
      expect(page).to have_content("You have deleted Fido!")
    end

    within(".all_cats") do
      expect(page).to_not have_content("Fido")
    end
  end
  scenario "user cannot delete a cat" do
    user = create_users[:user1]

    cat = create_cat

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit cat_path(cat)

    expect(page).to_not have_content("Delete #{cat.name}")
  end
  scenario "admin can delete a cat in an order" do
    admin = create_admin

    _, _, cat = create_integration

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)

    visit cat_path(cat)

    within(".all_cats") do
      expect(page).to have_content(cat.name)
    end

    click_on "Delete #{cat.name}"

    within(".flash") do
      expect(page).to have_content("You have deleted #{cat.name}")
    end

    within(".all_cats") do
      expect(page).to_not have_content(cat.name)
    end
  end
end
