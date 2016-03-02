require 'rails_helper'

RSpec.describe CatOrder, type: :model do
  it { should belong_to(:cat) }
  it { should belong_to(:order) }
  it { should validate_presence_of(:order_id) }
  it { should validate_presence_of(:cat_id) }
end
