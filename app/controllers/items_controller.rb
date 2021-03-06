class ItemsController < ApplicationController
  include BreadExpressHelpers::Cart
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  authorize_resource
  
  def index
    @items = Item.alphabetical.paginate(:page => params[:page]).per_page(10)
    @active_items = Item.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_items = Item.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def create
    @item = Item.new(item_params)
    
    if @item.save
      redirect_to @item, notice: "#{@item.name} was added to the system."
    else
      render action: 'new'
    end
  end

  def show
    @items_for_category = Item.active.for_category(@item.category).alphabetical
    @item_prices = ItemPrice.for_item(@item).chronological
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: "The item was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to items_url, notice: "This item was removed from the system."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :category, :picture, :units_per_item, :weight, :active, item_price_attributes: [:price, :start_date])
    end
end

