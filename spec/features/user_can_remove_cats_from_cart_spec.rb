require "rails_helper"

RSpec.feature "user can remove cats from cart" do
  scenario "user removes single cat from cart then adds it back" do
    cat = create_cat

    visit cats_path
    click_on "Add to Cart"
    click_on "Cart: 1"

    visit "/cart"

    click_on "Remove"

    expect(page).to have_content("Successfully removed #{cat.name} from cart")
    expect(page).to have_content("Total Price: $0.00")
    expect(page).to_not have_content(cat.price)
    expect(page).to_not have_content(cat.description)

    click_on "Fido"

    expect(page).to have_content("Price: $20.00")
    expect(page).to have_content(cat.description)
    expect(page).to have_content(cat.age)
  end
end
