class Cat < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :category
  has_many :cat_orders
  has_many :orders, through: :cat_orders
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates_numericality_of :price, greater_than: 0
  validates :description, presence: true
  validates :image, presence: true
  validates :age, presence: true
  validates :category_id, presence: true

  def format_price
    number_to_currency(price / 100.00)
  end

  def self.random_cat
    all.sample
  end

  def change_cat_status(cat)
    cat.update_attribute(:status, "inactive")
  end
end
