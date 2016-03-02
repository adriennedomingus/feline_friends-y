require "rails_helper"

RSpec.describe Order, type: :model do
  it { should belong_to :user }
  it { should have_many :cat_orders }
  it { should have_many :cats }
  it { should validate_presence_of :status }

  context "total sale" do
    it "totals the line items" do
      user, order, cat, cat2 = create_integration
      expect(order.total).to eq(cat.price + cat2.price)
    end
  end

  context "placed at" do
    it "knows when the order was placed" do
      user, order, cat, cat2 = create_integration

      expect(order.placed_at).to eq(order.created_at.strftime("%b %d, %Y"))
    end
  end
end
