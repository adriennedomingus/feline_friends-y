class OrdersController < ApplicationController
  before_action :require_user

  def index
  end

  def show
    @order = Order.find(params[:id])
  end
end
