class CategoriesController < ApplicationController
  before_action :set_category, only: [:index,:show]

  def ajax
    @categories = Category.order(id:"ASC").find(params[:parent_id]).children
    respond_to do |format|
      format.html {redirect_to :root}
      format.json {render json: @categories}
    end
  end

  def show
    @category = Category.find(params[:id])
    @items = Item.order(created_at:"DESC").where(category_id: @category.subtree_ids).limit(5).includes(:images)
  end

  private

  def set_category
    @categories = Category.order(id:"ASC").where(ancestry:nil)
  end

end
