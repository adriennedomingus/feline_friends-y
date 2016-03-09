require "rails_helper"

RSpec.describe Review, type: :model do
  it { should validate_presence_of :comment }
  it { should validate_presence_of :score }
  it { should validate_presence_of :cat_id }
  it { should belong_to :cat }
  it { should belong_to :user }

  context "score" do
    it "cannot have a score over 5" do
      user = create_users[:user1]
      cat = create_cat
      refute Review.create(score: 8, comment: "hello", cat_id: cat.id, user_id: user.id).valid?
    end
    it "cannot have a score less than 1" do
      user = create_users[:user1]
      cat = create_cat
      refute Review.create(score: 0, comment: "hello", cat_id: cat.id, user_id: user.id).valid?
    end
    it "has a score between 1 and 5" do
      user = create_users[:user1]
      cat = create_cat
      assert Review.create(score: 4, comment: "hello", cat_id: cat.id, user_id: user.id).valid?
    end
  end
end
