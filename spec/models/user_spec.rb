require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_many :orders }
  it { should belong_to :address }
  it { should validate_presence_of :address_id }

  context "format address" do
    it "formats the address for one line" do
      user = create_users[:user1]
      address = "4325 W. Palm Beach Rd., San Francisco, CA 94116 United States"

      expect(user.format_address).to eq(address)
    end
  end

  context "tells if the user has orders" do
    it "returns true if the user has orders" do
      user = create_users[:user1]
      user.orders.create
      expect(user.has_orders?).to be_truthy
    end
    it "returns false if the user has no orders" do
      user = create_users[:user1]
      expect(user.has_orders?).to be_falsey
    end
  end
end
