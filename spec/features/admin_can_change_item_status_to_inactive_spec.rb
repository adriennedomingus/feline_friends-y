require "rails_helper"

RSpec.feature "admin changes status of an item" do
  scenario "admin changes cat status from active to inactive" do
    admin = create_admin

    cat = create_cat

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(admin)

    visit cat_path(cat)

    within(".all_cats") do
      expect(page).to have_content("Fido")
    end

    click_on "Change Status to Inactive"

    within(".flash") do
      expect(page).to have_content("You have
                                   changed #{cat.name}'s status to inactive!")
    end
  end
  scenario "user cannot change status of a cat" do
    user = create_users[:user1]

    cat = create_cat

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit cat_path(cat)

    expect(page).to_not have_content("Change Status to Inactive")
  end
end
