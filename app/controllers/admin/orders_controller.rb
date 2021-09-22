class Admin::OrdersController < ApplicationController
  
  def index
    @orders = Order.all
  end

  def show
    @orders = Order.all
    @order = Order.find(params[:id])
    @order_products = OrderProduct.all
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(orders_params)
      redirect_to admin_order_path(@order),notice: "注文ステータス変更しました"
    else
      render :show
    end
  end

  private

  def orders_params
    params.require(:order).permit(:status)
  end

end
