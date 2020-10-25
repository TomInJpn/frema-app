class Users::ShowsController < ApplicationController

  def show
    @categories = Category.order("id ASC").where(ancestry:nil)
  end

end