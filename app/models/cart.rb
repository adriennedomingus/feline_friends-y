class Cart
  include ActionView::Helpers::NumberHelper
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_cat(cat)
    contents[cat.to_s] ||= 0
    contents[cat.to_s] += 1
  end

  def total_price
    total = contents.map do |cat, count|
      cat = Cat.find(cat.to_i)
      cat.price * count
    end
    if !total.empty?
      number_to_currency(total.reduce(:+) / 100.00)
    else
      0
    end
  end
end
