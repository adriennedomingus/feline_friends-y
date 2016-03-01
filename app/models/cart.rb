class Cart
  include ActionView::Helpers::NumberHelper
  attr_reader :contents, :double_click

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
      "$0.00"
    end
  end

  def remove_cat(cat_id)
    contents.delete(cat_id.to_s)
  end

  def double_click?(cat_id)
    if contents[cat_id.to_s].nil? || contents[cat_id.to_s] == 1
      return false
    else
      return true
    end
  end
end
