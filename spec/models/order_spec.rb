require "rails_helper"

RSpec.describe Order, type: :model do
  it { should belong_to :user }
  it { should have_many :cat_orders }
  it { should have_many :cats }
  it { should validate_presence_of :status }

  context "total sale" do
    it "totals the line items" do
      _, order = create_integration
      expect(order.total).to eq("$50.00")
    end
  end

  context "placed at" do
    it "knows when the order was placed" do
      _, order = create_integration

      expect(order.format_time(order.created_at)).
        to eq(order.created_at.strftime("%b %d, %Y at %l:%M %p UTC"))
    end
  end

  context "length in days" do
    it "knows how long the reservation is" do
      start_date = Date.new(2016, 03, 01)
      end_date = Date.new(2016, 03, 04)
      order = Order.new(start_date: start_date, end_date: end_date)

      expect(order.days).to eq(3)
    end
  end

  context "already reserved cats" do
    it "knows when one or more cats are already reserved" do
      create_integration
      _, order2 = create_integration

      expect(Order.reserved?(order2)).to eq(true)
    end
  end
end
