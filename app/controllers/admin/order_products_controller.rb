class Admin::OrderProductsController < ApplicationController

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
  end
end
