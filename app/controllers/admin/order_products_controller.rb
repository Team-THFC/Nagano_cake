class Admin::OrderProductsController < ApplicationController

  def update
    @order_product = OrderProduct.find(params[:id])
    @order_product.update(order_product_params)
    @order_products = @order_product.order.order_products
    if @order_product.production_status == "製作中"
      @order_product.order.update(status: "製作中")
    elsif @order_products.all? {|order_product| order_product.production_status == "製作完了" }
      @order_product.order.update(status: "発送準備中")
    end
    redirect_to admin_order_path(@order_product.order)
  end

  private

  def order_product_params
    params.require(:order_product).permit(:production_status, :order_id)
  end
end
