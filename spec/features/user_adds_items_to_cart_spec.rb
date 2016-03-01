require "rails_helper"

RSpec.feature "visitor can view cats" do
  scenario "visitor can view all cats" do
    path = "http://www.altpress.com/images/uploads/news/Hello_Kißtty.jpg"
    category = Category.create(name: "Fluffy")
    category.cats.create(
      name: "Fido",
      age: 2,
      description: "Actually a dog",
      image: path,
      price: 2000)

    visit cats_path
    click_on "Add to Cart"
    click_on "Cart: 1"

    expect(current_path).to eq(cart_path)
    expect(page).to have_content("Fido")
    expect(page).to have_content("Actually a dog")
    expect(page).to have_content("$20.00")
    expect(page).to have_content("Total Price: $20.00")
  end
end
