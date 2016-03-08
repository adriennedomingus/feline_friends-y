class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
  end

  def update
    if params[:status] == "Cancel"
      Order.update(params[:id], status: 2, start_date: nil, end_date: nil)
    elsif params[:status] == "Return"
      Order.update(params[:id], status: 1, end_date: Date.today)
    end
    redirect_to admin_dashboard_path
  end

  def show
    @order = Order.find(params[:id])
  end
end
