require "rails_helper"

RSpec.feature "user rates a cat" do
  scenario "logged in user rates and leaves a comment about a cat" do
    user = create_users[:user1]
    cat = create_cat

    allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(user)

    visit cat_path(cat)

    select "5", from: "review[score]"
    fill_in "Comment", with: "This kitteh exemplifies the wonderful feline race"
    click_on "Create Review"

    expect(page).to have_content(5)
    expect(page).to have_content("This kitteh exemplifies the wonderful feline race")

    within(".flash") do
      expect(page).to have_content("You added a review of Fido!")
    end
  end
  scenario "logged in user does not complete all fields in review" do
    user = create_users[:user1]
    cat = create_cat

    allow_any_instance_of(ApplicationController).
        to receive(:current_user).and_return(user)

    visit cat_path(cat)

    select "5", from: "review[score]"
    click_on "Create Review"

    within(".flash") do
      expect(page).to have_content("Please complete all fields")
    end
  end
  scenario "unregistered user cannot review a cat" do
    cat = create_cat

    visit cat_path(cat)

    expect(page).to_not have_content("Create Review")
  end
end
