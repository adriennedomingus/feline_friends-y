class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
  end

  def update
    Order.update(params[:id], status: params[:status].to_i)
    redirect_to admin_dashboard_path
  end

  def show
    @order = Order.find(params[:id])
  end
end
