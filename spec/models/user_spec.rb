require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_many :orders }
  it { should belong_to :address }

  context "format address" do
    it "formats the address for one line" do
      user = create_users[:user1]

      expect(user.format_address).to eq("4325 W. Palm Beach Rd., San Francisco, CA 94116 United States")
    end
  end
end
