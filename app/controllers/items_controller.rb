class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  authorize_resource
  
  def index
    @items = Item.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @items_for_category = Item.for_category(@item.category).alphabetical
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
    def address_params
      params.require(:item).permit(:name, :description, :category, :picture, :units_per_item, :weight, :active)
    end
end

