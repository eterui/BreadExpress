class OrdersController < ApplicationController
  include BreadExpressHelpers::Cart
  include BreadExpressHelpers::Shipping

  before_action :check_login
  before_action :set_order, only: [:show, :update, :destroy]
  authorize_resource
  
  def index
    if logged_in? && !current_user.role?(:customer)
      @pending_orders = Order.not_shipped.chronological.paginate(:page => params[:page]).per_page(5)
      @all_orders = Order.chronological.paginate(:page => params[:page]).per_page(5)
    else
      @pending_orders = current_user.customer.orders.not_shipped.chronological.paginate(:page => params[:page]).per_page(5)
      @all_orders = current_user.customer.orders.chronological.paginate(:page => params[:page]).per_page(5)
    end 
  end

  def cart
    @items_in_cart = get_list_of_items_in_cart
    @subtotal = calculate_cart_items_cost
    @shipping_cost = calculate_cart_shipping
    @grand_total = @subtotal+@shipping_cost
  end

  def add_item
    @added_item = add_item_to_cart(params[:id])
    redirect_to items_url, notice: "Added #{Item.find(params[:id]).name} to cart"
  end

  def remove_item
    @removed_item = remove_item_from_cart(params[:id])
    redirect_to cart_url, notice: "Removed #{Item.find(params[:id]).name} from cart"
  end

  def drop_cart
    destroy_cart
    create_cart
    redirect_to cart_url
  end

  def show
    @order_items = @order.order_items.to_a
    if current_user.role?(:customer)
      @previous_orders = current_user.customer.orders.chronological.to_a
    else
      @previous_orders = @order.customer.orders.chronological.to_a
    end
  end

  def new
    @items_in_cart = get_list_of_items_in_cart
    @subtotal = calculate_cart_items_cost
    @shipping_cost = calculate_cart_shipping
    @grand_total = @subtotal+@shipping_cost
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer = current_user.customer
    @order.date = Date.today
    @order.grand_total = calculate_cart_items_cost + calculate_cart_shipping

    if @order.save
      save_each_item_in_cart(@order)
      @order.pay
      redirect_to @order, notice: "Thank you for ordering from Bread Express."
      destroy_cart
      create_cart
    else
      @items_in_cart = get_list_of_items_in_cart
      @subtotal = calculate_cart_items_cost
      @shipping_cost = calculate_cart_shipping
      @grand_total = @subtotal+@shipping_cost
      render action: 'new'
    end
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: "Your order was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url, notice: "This order was removed from the system."
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params[:order][:expiration_month] = params[:order][:expiration_month].to_i
    params[:order][:expiration_year] = params[:order][:expiration_year].to_i
    params.require(:order).permit(:address_id, :credit_card_number, :expiration_month, :expiration_year)
  end







end