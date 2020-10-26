class ItemsController < ApplicationController
  before_action :set_item,          except: [:index,:new,:create]
  before_action :set_category,      except: [:destroy]
  before_action :authenticate_user!,except: [:index,:show]

  def index
    @items = Item.order(created_at:"DESC").limit(5)
  end

  def show
    @item_ancestors = @item.category.ancestors
    @items = Item.where(category_id:@item.category_id).order(created_at:"DESC").limit(5)
  end

  def new
    @item = Item.new
    @image = @item.images.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to new_item_path
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @item.user_id == current_user.id && @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :category_id,
      :brand,
      :condition_id,
      :shipment_fee_id,
      :prefecture_id,
      :shipment_schedule_id,
      :stock,
      :price,
      images_attributes:[:image,:image_cache,:id,:_destroy],
    )
    .merge(user_id:current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_category
    @categories = Category.order(id:"ASC").where(ancestry:nil)
  end

end