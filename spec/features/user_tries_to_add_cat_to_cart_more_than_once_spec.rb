RSpec.feature "User tries to add a specific cat more than once to the cart" do
  scenario "they see a flash notice of cannot add to cart" do
    cat = create_cats[0]
    create_categories[0].cats << cat

    visit "/cats"

    click_on "Add to Cart"
    click_on "Add to Cart"

    flash = "You have already added #{cat.name} to your cart!"

    expect(page).to have_content flash
  end
end
