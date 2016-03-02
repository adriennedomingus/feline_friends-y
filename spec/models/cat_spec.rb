require "rails_helper"

RSpec.describe Cat, type: :model do
  it { should belong_to :category }
  it { should have_many :cat_orders }
  it { should have_many :orders }
  it { should validate_presence_of :name }
  it { should validate_presence_of :price }
  it { should validate_presence_of :description }
  it { should validate_presence_of :image }
  it { should validate_presence_of :age }
  it { should validate_presence_of :category_id }

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
