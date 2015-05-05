class ItemPricesController < ApplicationController
  before_action :set_item_price, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def new
    @item_price = ItemPrice.new
  end

  def create
    @item_price = ItemPrice.new(item_price_params)
    @item_price.start_date = Date.today
    @item = @item_price.item
    if @item_price.save
      redirect_to @item, notice: "#{@item_price.item.name} price was added to the system."
    else
      render action: 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item_price.update(item_price_params)
      redirect_to @item_price.item, notice: "The item's price was revised in the system"
    else
      render action: 'edit'
    end
  end


  def destroy
  end

  private
    def set_item_price
      @item_price = ItemPrice.find(params[:id])
    end

    def item_price_params
      params.require(:item_price).permit(:item_id, :price) 
    end
end
