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
    # item = Item.find(params[:item_id])
    # begin
    #   item.with_lock do
    #     item.stock -= params[:quantity].to_i
    #     postage = Postage.find(item.user.address.prefecture_id) if item.shipment_fee_id == 2
    #     payment = Payment.new(payment_params)
    #     payment.payment = item.price * params[:quantity].to_i
    #     payment.payment += postage[:"#{current_user.address.prefecture_id}"] if item.shipment_fee_id == 2
    #     Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    #     charge = Payjp::Charge.create(
    #       amount:   payment.payment,
    #       customer: Card.find_by(user_id: current_user.id).customer_id,
    #       currency: 'jpy'
    #     )
    #     payment.charge_id = charge.id
    #     payment.user_id   = item.user_id

    #     payment.save!
    #     item.update!(stock: item.stock)
    #   end
    # rescue
    #   Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    #   customer = Payjp::Customer.retrieve(current_user.card.customer_id) if current_user.card
    #   @card = customer.cards.retrieve(current_user.card.card_id) if current_user.card
    #   @item = Item.find(params[:item_id])
    #   @shipment_fee = ShipmentFee.find(@item.shipment_fee_id)
    #   @postage = Postage.find(@item.user.address.prefecture_id) if @shipment_fee.id == 2
    #   render "new"
  end

  private
  def payment_params
    params.permit(
      :item_id,
      :quantity,
    ).merge(buyer_id: current_user.id)
  end

end
