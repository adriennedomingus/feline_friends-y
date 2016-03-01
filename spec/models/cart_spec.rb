require "rails_helper"

RSpec.describe Cart, type: :model do
  context "valid params" do
    it "has initial contents" do
      cart = Cart.new("1" => 1)

      expect(cart.contents).to eq("1" => 1)
    end

    it "can add a cat" do
      cart = Cart.new("1" => 1)

      cart.add_cat(1)
      cart.add_cat(2)

      expect(cart.contents).to eq("1" => 2, "2" => 1)
    end

    it "can remove a cat" do
      cart = Cart.new("1" => 1)

      cart.add_cat(1)
      cart.add_cat(2)
      cart.remove_cat(2)

      expect(cart.contents).to eq("1" => 2)
    end

    it "can total the price" do
      path = "http://www.altpress.com/images/uploads/news/Hello_Kißtty.jpg"
      category = Category.create(name: "Fluffy")
      category.cats.create(
        name: "Fido",
        age: 2,
        description: "Actually a dog",
        image: path,
        price: 2000)

      category.cats.create(
        name: "Mena",
        age: 2,
        description: "Mine",
        image: path,
        price: 3000)

      cart = Cart.new({})

      cart.add_cat(Cat.first.id)
      cart.add_cat(Cat.last.id)
      cart.add_cat(Cat.last.id)

      expect(cart.total_price).to eq("$80.00")
    end

    it "can check for double addition to the cart" do
      cat = create_cats[0]
      create_categories[0].cats << cat
      cart = Cart.new({})
      cart.add_cat(cat.id)
      cart.add_cat(cat.id)
      expect(cart.double_click?(cat.id)).to eq(true)
    end
  end
end
