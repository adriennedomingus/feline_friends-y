class Cat < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  def format_price
    number_to_currency(price / 100.00)
  end
end
