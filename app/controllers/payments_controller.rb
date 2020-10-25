class PaymentsController < ApplicationController
  before_action :authenticate_user!
  def new
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.retrieve(current_user.card.customer_id) if current_user.card
    @card = customer.cards.retrieve(current_user.card.card_id) if current_user.card
    @item = Item.find(params[:item_id])
    @shipment_fee = ShipmentFee.find(@item.shipment_fee_id)
    @postage = Postage.find(@item.user.address.prefecture_id) if @shipment_fee.id == 2
  end

  def create
    # ActiveRecord::Base.transaction do
      item = Item.find(params[:item_id])
      item.stock -= params[:quantity].to_i
      payment = Payment.new(payment_params)
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      charge = Payjp::Charge.create(
        amount: item.price.to_i * params[:quantity].to_i,
        customer: Card.find_by(user_id: current_user.id).customer_id,
        currency: 'jpy'
      )
      payment.charge_id = charge.id
    #   payment.save!
    #   item.update!(stock: item.stock)
    # end
    if payment.save && item.update(stock: item.stock)
      redirect_to root_path
    # rescue
    else
      @item = Item.find(params[:item_id])
      @shipment_fee = ShipmentFee.find(@item.shipment_fee_id)
      render "new"
    end
  end

  private
  def payment_params
    params.permit(
      :item_id,
      :quantity,
    ).merge(user_id: current_user.id)
  end

end
