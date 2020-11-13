class CardController < ApplicationController
  before_action :authenticate_user!
  def new
    if current_user&.card
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(current_user.card.customer_id)
      @card = customer.cards.retrieve(current_user.card.card_id)
    else
      @api_key = ENV["PAYJP_PUBLIC_KEY"]
      # gon.api_key = ENV["PAYJP_PUBLIC_KEY"]
    end
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    if params["payjp-token"].blank?
      render :new
    else
      customer = Payjp::Customer.create(
        card: params["payjp-token"]
      )
      @card = Card.new(
        user_id: current_user.id,
        customer_id: customer.id,
        card_id: customer.default_card
      )
      if @card.save
        redirect_to new_card_path
      else
        render :new
      end
    end
  end

  def destroy
    if Card.find(params[:id]).destroy
      redirect_to new_card_path
    end
  end

end
