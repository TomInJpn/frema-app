class CategoriesController < ApplicationController
  def ajax
    @categories = Category.order(id:"ASC").find(params[:parent_id]).children
    respond_to do |format|
      format.html {redirect_to :root}
      format.json {render json: @categories}
    end
  end

  def show
    @category = Category.find(params[:id])
    @categories = Category.order(id:"ASC").where(ancestry:nil)
    @items = Item.order(created_at:"DESC").where(category_id: @category.subtree_ids).limit(5).includes(:images)
  end

end
