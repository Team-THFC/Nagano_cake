class Admin::OrderProductsController < ApplicationController

  def update
    @order_product = OrderProduct.find_by(id: params[:id], order_id: params[:order_id])
    if @order_product.update(order_product_params)
      redirect_to admin_order_path(@order_product.order),notice: "制作ステータス変更しました"
    else
      render :show
    end
  end

  private

  def order_product_params
    params.require(:order_product).permit(:production_status, :order_id)
  end
end
