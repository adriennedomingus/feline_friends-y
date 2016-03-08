class Review < ActiveRecord::Base
  belongs_to :cat
  validates :comment, presence: true
  validates :score, presence: true, numericality: {greater_than: 0, less_than: 6 }
end
