require "rails_helper"

RSpec.describe Review, type: :model do
  it { should validate_presence_of :comment }
  it { should validate_presence_of :score }

  context "score" do
    it "cannot have a score over 5" do
      refute Review.create(score: 8, comment: "hello").valid?
    end
    it "has a score between 1 and 5" do
      assert Review.create(score: 4, comment: "hello").valid?
    end
  end
end
