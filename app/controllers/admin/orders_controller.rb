class Admin::OrdersController < ApplicationController
  
  def index
    @orders = Order.all
  end

  def show
    @orders = Order.all
    @order = Order.find(params[:id])
    @order_products = OrderProduct.where(order_id: @order)
  end

  def update
    @order = Order.find(params[:id])
    @order.update(orders_params)
    redirect_to admin_order_path(@order)
  end

  private

  def orders_params
    params.require(:order).permit(:member_id,:shipping_price,:total_payment,:payment_method,:name,:address,:postal_code,:status)
  end

end
