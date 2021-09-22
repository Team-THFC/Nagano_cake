class Admin::OrderProductsController < ApplicationController
<<<<<<< HEAD
  def update
    @order = Order.find_by(id: params[:order_id])
    @order_product = OrderProduct.find_by(id: params[:id],order_id: params[:order_id])
    @order_product.update(order_product_params)
    redirect_to admin_order_path(@order)
  end

  private
  def order_product_params
   params.require(:order_product).permit(:product_id,:order_id,:quantity,:price,:production_status)
=======

  def update
    @order_product = OrderProduct.find(params[:id])
    if @order_product.update(order_product_params)
      redirect_to admin_order_path(@order_product.order),notice: "制作ステータス変更しました"
    else
      render :show
    end
  end

  private

  def order_products_params
    params.require(:order_product).permit(:production_status)
>>>>>>> 32d23ff5dae014545a443ba5cb87862af1d81ea0
  end
end

