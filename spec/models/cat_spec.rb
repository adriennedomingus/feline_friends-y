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
      cat = create_cat

      expect(cat.format_price).to eq("$20.00")
    end
  end

  context "return a random cat" do
    it "returns a cat" do
      create_integration

      expect(Cat.random_cat.class).to eq(Cat)
    end
  end
end
