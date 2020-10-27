class SearchesController < ApplicationController

  def ajax
    @searches = Item.order(created_at:"DESC").where("name LIKE ? OR description LIKE ?","%#{params[:search]}%","%%#{params[:search]}%%").limit(10)
    respond_to do |format|
      format.html {redirect_to :root}
      format.json {render json: @searches}
    end
  end

end
