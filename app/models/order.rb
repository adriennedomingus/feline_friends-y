class Order < ActiveRecord::Base
  belongs_to :user
  has_many :cat_orders
  has_many :cats, through: :cat_orders
  validates :status, presence: true
  enum status: %w(rented returned cancelled)

  def total
    cats.sum(:price)
  end

  def placed_at
    created_at.strftime("%b %d, %Y")
  end
end
