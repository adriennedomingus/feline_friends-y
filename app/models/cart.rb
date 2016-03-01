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
      Cat.find(cat.to_i).price
    end
    number_to_currency(total.reduce(:+).to_i / 100.00)
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

  def add_contents_to_cart(contents)
    contents.map do |cat, _|
      Cat.find(cat.to_i)
    end
  end
end
