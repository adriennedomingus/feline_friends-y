require "rails_helper"

RSpec.describe Address, type: :model do
  it { should have_many :users }
end
