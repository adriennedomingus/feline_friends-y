class Order < ActiveRecord::Base
  belongs_to :user
  has_many :cat_orders
  has_many :cats, through: :cat_orders
  validates :status, presence: true
  enum status: %w(rented returned cancelled)

  def total
    cats.sum(:price)
  end

  def format_time(time)
    time.strftime("%b %d, %Y at %l:%M %p UTC")
  end
end
