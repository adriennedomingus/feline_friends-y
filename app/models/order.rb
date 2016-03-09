class Order < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :user
  has_many :cat_orders, dependent: :destroy
  has_many :cats, through: :cat_orders
  validates :status, presence: true
  enum status: %w(rented returned cancelled)

  def total
    if days
      number_to_currency(cats.sum(:price) * days / 100)
    end
  end

  def format_time(time)
    time.strftime("%b %d, %Y at %l:%M %p UTC")
  end

  def format_date(date)
    date.strftime("%b %d, %Y")
  end

  def create_order(cart, start_date_params, end_date_params)
    cart.contents.keys.each do |cat|
      cats << Cat.find(cat.to_i)
    end
    # year, month, day = start_date_params
    # end_year, end_month, end_day = end_date_params
    assign_attributes(start_date: create_start_date(start_date_params))
    assign_attributes(end_date: create_start_date(end_date_params))
  end

  def create_start_date(date_params)
    date = date_params.gsub(",", "").split.reverse
    date[1] = Date::MONTHNAMES.index(date[1])
    Date.new(date[0].to_i, date[1], date[2].to_i)
  end

  def range
    if start_date
      start_date.to_datetime..end_date.to_datetime
    end
  end

  def days
    if end_date && start_date
      (end_date.to_datetime - start_date.to_datetime).to_i
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
