require "rails_helper"

RSpec.feature "visitor can add cats to cart" do
  scenario "visitor can add cat to cart" do
    cat = create_cat

    visit cats_path
    click_on "Add to Cart"

    expect(page).to have_content("#{cat.name} has been added to your cart!")
    click_on "Cart: 1"

    expect(current_path).to eq(cart_path)
    expect(page).to have_content("Fido")
    expect(page).to have_content("Actually a dog")
    expect(page).to have_content("$20.00")
    expect(page).to have_content("Total Price: $20.00")
  end
end
