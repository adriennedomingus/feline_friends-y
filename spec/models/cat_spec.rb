require "rails_helper"

RSpec.describe Cat, type: :model do
  context "formats price" do
    it "formats the price" do
      path = "http://www.altpress.com/images/uploads/news/Hello_Kitty.jpg"
      cat = Cat.create(
        name: "Fido",
        age: 2,
        description: "Actually a dog",
        image: path,
        price: 2000
                      )
      expect(cat.format_price).to eq("$20.00")
    end
  end
end
