class Users::SignoutsController < ApplicationController

  before_action :authenticate_user!,except: [:signout]

  def signout
  end

end