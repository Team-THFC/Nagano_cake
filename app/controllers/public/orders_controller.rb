class Public::OrdersController < ApplicationController

   before_action :authenticate_member!

  def new
    @order = Order.new
    @member = current_member
    @member_cart_products = CartProduct.where(member_id: current_member.id)
  	@addresses = Address.where(member_id: current_member.id)

  end

  def confirm
    @order = Order.new(
      member: current_member,
      payment_method: params[:order][:payment_method]
    )

    @member_cart_products = CartProduct.where(member_id: current_member.id)
    #@order.total_payment = billing(@order)

    if params[:order][:addresses] == "residence"
      @order.postal_code = current_member.postal_code
      @order.address     = current_member.address
      @order.name        = current_member.last_name +
                           current_member.first_name
    elsif params[:order][:addresses] == "address"
      ship = Address.find(params[:order][:address_id])
      @order.postal_code = ship.postal_code
      @order.address     = ship.address
      @order.name        = ship.name

    elsif params[:order][:addresses] == "new_address"
      @order.postal_code = params[:order][:postal_code]
      @order.address     = params[:order][:address]
      @order.name        = params[:order][:name]
      @ship = "1"

      unless @order.valid?
         @addresses = Address.where(member: current_member)

      end
    end
  end

  def create
     @order = current_member.orders.new(order_params)

    @order.save!
    redirect_to finish_public_orders_path
    if params[:order][:ship] == "1"
      current_member.address.create(address_params)
    end

     @member_cart_products = CartProduct.where(member_id: current_member.id)

     @member_cart_products.each do |cart|
     OrderProduct.create(
      product:  cart.product,
      order:    @order,
      quantity: cart.quantity,
      price: @order.total_payment
    )
    end



    @member_cart_products.destroy_all

  end

  def finish

  end

  def index
    @order = Order.all
    @orders = Order.where(member_id: current_member.id)
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
  end

   private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment, :shipping_price,)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end




end
