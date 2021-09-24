class Admin::OrderProductsController < ApplicationController

  def update
    @order_product = OrderProduct.find(params[:id])
    @order_product.update(order_product_params)
    order = @order_product.order
    @order_products = order.order_products
    order_products_completed = @order_products.where(status: "製作完了")
    if @order_product.production_status == "製作中"
      @order_product.order.status = "製作中"
      @order_product.order.save
    elsif @order_products.count == order_products_completed.count
      @order_product.order.status = "発送準備中"
      @order_product.order.save
    end
    redirect_to admin_order_path(@order_product.order)
  end


  private

  def order_product_params
    params.require(:order_product).permit(:production_status, :order_id)
  end
end
