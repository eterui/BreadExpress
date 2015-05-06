class HomeController < ApplicationController
  include BreadExpressHelpers::Baking

  #PUT BAKING LIST AND SHIPPING LIST DASHBOARD HERE OR CHANGE WHERE THEY REDIRECT TO

  def home
    @unshipped_orders_backwards = Order.chronological.not_shipped
    @unshipped_orders = Order.chronological.not_shipped.reverse_each
    @muffins_baking_list = create_baking_list_for("muffins")
    @bread_baking_list = create_baking_list_for("bread")
    @pastries_baking_list = create_baking_list_for("pastries")
    @whole_list = [@muffins_baking_list, @bread_baking_list, @pastries_baking_list]

  end

  def about
  end

  def privacy
  end

  def contact
  end






end