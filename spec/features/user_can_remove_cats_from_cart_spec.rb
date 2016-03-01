require "rails_helper"

RSpec.feature "user can remove cats from cart" do
  scenario "user removes single cat from cart then adds it back" do
    pending
    category = Category.create(name: "Fluffy")
    image_path = "http://favim.com/orig/201104/14/Favim.com-18038.jpg"

    cat = Cat.create(
      name: "Fido",
      age: 2,
      description: "Actually a dog",
      image: image_path,
      price: 2000,
      category_id: category.id)

    cat.add_to_cart

    visit '/cart'

    click_on "Remove"

    within(".cart_messages") do
      expect(page).to have_content("Successfully removed #{cat.name} from cart.")
      expect(page).to have_content("Cart total: $0.00")
      expect(page).to_not have_content(cat.price) #or some other indicator that it is no longer in cart?
      expect(page).to_not have_content(cat.description)
      expect(page).to_not have_content(cat.age)
    end

    click_on "Fido"

    within(".cart_messages") do
      expect(page).to have_content("Cart total: $20.00")
      expect(page).to have_content(cat.price) #or some other indicator that it is no longer in cart?
      expect(page).to have_content(cat.description)
      expect(page).to have_content(cat.age)
    end
  end
end
