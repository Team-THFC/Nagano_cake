class Public::OrdersController < ApplicationController

   before_action :authenticate_member!

  def new
    @order = Order.new
  	@addresses = Address.where(member: current_member)
  end

  def confirm
    @order = Order.new(order_params)
    @member_cart_products = CartProduct.where(member: current_member)
    if params[:order][:addresses] == "residence"
      
    elsif params[:order][:addresses] == "address_params"

    elsif params[:order][:addresses] == "new_address"

    unless @order.valid?
      render :new
    end
    end
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to finish_public_orders_path
    end
  end

  def finish

  end

  def index
    @orders = current_member.orders
    @orders = Order.all
  end

  def show
    #@order = Order.find(params[:id])
    #@order_products = @order.order_products
  end

   private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end


end
