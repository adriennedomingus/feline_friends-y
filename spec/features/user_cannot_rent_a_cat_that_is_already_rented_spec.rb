require "rails_helper"

RSpec.feature "user cannot rent a rented cat" do
  scenario "a user who rents a cat can no longer add it to their cart" do
    create_cat
    user = create_users[:user1]

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)

    visit cats_path

    click_on "Add to Cart"
    visit "/cart"
    click_on "Checkout"
    visit cats_path

    expect(page).to have_content("I've been rented!")
    expect(page).to_not have_content("Add to Cart")
  end
end
