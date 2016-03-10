require "rails_helper"

RSpec.describe Order, type: :model do
  it { should belong_to :user }
  it { should have_many :cat_orders }
  it { should have_many :cats }

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

  context "creating a date" do
    it "creates a date from params" do
      order = Order.new
      expect(order.create_date("3 March, 2016")).to eq(Date.new(2016, 03, 03))
    end
  end

  context "date range" do
    it "has a date range" do
      order = Order.new(start_date: Date.new(2016, 03, 03),
                        end_date: Date.new(2016, 05, 05))

      expect(order.range).
        to eq(DateTime.new(2016, 03, 03)..DateTime.new(2016, 05, 05))
    end
  end

  context "overdue" do
    it "knows whether it is overdue or not" do
      order = Order.new(end_date: Date.new(2016, 01, 01))

      expect(order.overdue?).to be_truthy
    end
  end
end
