class HomeController < ApplicationController
  include BreadExpressHelpers::Baking

  #PUT BAKING LIST AND SHIPPING LIST DASHBOARD HERE OR CHANGE WHERE THEY REDIRECT TO

  def home
    @unshipped_orders = Order.chronological.not_shipped.reverse_each

  end

  def about
  end

  def privacy
  end

  def contact
  end






end