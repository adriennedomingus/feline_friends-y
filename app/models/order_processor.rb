class OrderProcessor
  def self.process(order, cart, start_date_params, end_date_params)
    order.create_order(cart, start_date_params, end_date_params)
    if !cart.contains_cats?
      message = "Your cart is empty"
    elsif order.end_date <= order.start_date
      message = "Your reservation must end at least one day after your start date"
    elsif order.start_date < Date.today
      message = "You cannot make a reservation in the past"
    elsif order.cats.any? { |cat| cat.orders.reserved?(order) }
      message = "One of the cats in your order is already reserved on that date."
    end
    message
  end
end
