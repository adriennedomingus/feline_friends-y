require "rails_helper"

RSpec.feature "Visitor can rent a random cat" do
  scenario "visitor views a random cat in their cart" do
    create_integration

    visit "/"

    click_on "Rent a random cat"

    expect(current_path).to eq(cats_path)

    expect(page).to have_content "Cart: 1"
  end
end
