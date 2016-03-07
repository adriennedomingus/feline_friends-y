class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
  end

  def update
    if params[:status] == "Cancel"
      Order.update(params[:id], status: 2)
    elsif params[:status] == "Return"
      Order.update(params[:id], status: 1)
    end
    redirect_to admin_dashboard_path
  end

  def show
    @order = Order.find(params[:id])
  end
end
