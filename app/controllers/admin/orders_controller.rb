class Admin::OrdersController < ApplicationController

  def show
    @orders = Order.all
    @order = Order.find(params[:id])
    @orders_params = OrderProduct.all
   
  end

  private

  def orders_params
    params.require(:order).permit(:member_id,:shipping_price,:total_payment,:payment_method,:name,:address,:postal_code,:status)
  end

end
