class Admin::OrdersController < ApplicationController

  def show
    @orders = Order.all
    @order = Order.find(params[:id])
    @order_products = OrderProduct.where(order_id: @order.id)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_order_path(@order),notice: "注文ステータス変更しました"
    else
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
