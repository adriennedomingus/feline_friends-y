class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
  end

  def update
    Order.update(params[:id], status: params[:status].to_i)
    if params[:status] == "1"
      Order.update(params[:id], returned_at: Time.now)
    elsif params[:status] == "2"
      Order.update(params[:id], cancelled_at: Time.now)
    end
    redirect_to admin_dashboard_path
  end

  def show
    @order = Order.find(params[:id])
  end
end
