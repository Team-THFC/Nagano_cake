class Admin::OrderProductsController < ApplicationController
  def update
    @order = Order.find_by(id: params[:order_id])
    @order_product = OrderProduct.find_by(id: params[:id],order_id: params[:order_id])
    @order_product.update(order_product_params)
    redirect_to admin_order_path(@order)
  end

  private
  def order_product_params
   params.require(:order_product).permit(:product_id,:order_id,:quantity,:price,:production_status)
  end
end

