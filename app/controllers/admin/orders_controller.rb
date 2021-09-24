class Admin::OrdersController < ApplicationController

  def show
    @orders = Order.all
    @order = Order.find(params[:id])
    @order_products = OrderProduct.where(order_id: @order.id)
  end

  def update
    @order = Order.find(params[:id])
    @order_products = @order.order_products
    @order.update(order_params)

    if @order.status == "入金確認"
        @order_products.update_all(production_status: "制作待ち")
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
