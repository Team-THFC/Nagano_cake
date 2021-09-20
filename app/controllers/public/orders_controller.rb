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
      @order.postal_code = current_member.postal_code
      @order.address     = current_member.address
      @order.name        = current_member.last_name +
                           current_member.first_name
    elsif params[:order][:addresses] == "addresses"
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
        render :new
      end
    end
  end

  def create
    @order = current_member.order.new(order_params)
    if @order.save
      redirect_to finish_public_orders_path
    end
    if params[:order][:ship] == "1"
      current_member.address.create(address_params)
    end

     @cart_products = current_cart
     @cart_products.each do |cart_product|
     OrderDetail.create(
      product:  cart_product.product,
      order:    @order,
      quantity: cart_product.quantity,
      price: price(cart_product)
    )
      @cart_products.destroy_all
    end

  end

  def finish

  end

  def index
    @orders = current_member.orders
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
  end

   private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment, :postage)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end




end
