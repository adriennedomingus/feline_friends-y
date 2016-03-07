class Order < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :user
  has_many :cat_orders, dependent: :destroy
  has_many :cats, through: :cat_orders
  validates :status, presence: true
  enum status: %w(rented returned cancelled)

  def total
    number_to_currency(cats.sum(:price) / 100.0)
  end

  def format_time(time)
    time.strftime("%b %d, %Y at %l:%M %p UTC")
  end

  def format_date(date)
    date.strftime("%b %d, %Y")
  end

  def create_order(cart, date_params)
    cart.contents.keys.each do |cat|
      cats << Cat.find(cat.to_i)
    end
    year, month, day = date_params
    assign_attributes(start_date: Date.new(year, month, day))
    assign_attributes(end_date: start_date + 7.days)
  end

  def range
    if start_date
      start_date.to_datetime..end_date.to_datetime
    end
  end

  def overdue?
    if end_date
      status == "rented" && Date.today > end_date.to_datetime
    end
  end

  def self.reserved?(order)
    any? { |the_order| the_order.range === order.start_date }
  end

  def self.status_count(status)
    where(status: status).count
  end
end
