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
    Item.transaction do
      item = Item.find(params[:item_id])
      item.stock -= params[:quantity].to_i
      payment = Payment.new(payment_params)
      payment.payment = item.price * params[:quantity].to_i
      if  item.shipment_fee_id == 2
        postage = Postage.find(item.user.address.prefecture_id)
        payment.payment += postage[:"#{current_user.address.prefecture_id}"]
      end

      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      charge = Payjp::Charge.create(
        amount:   payment.payment,
        customer: Card.find_by(user_id: current_user.id).customer_id,
        currency: 'jpy',
      )

      payment.charge_id = charge.id
      payment.user_id   = item.user_id

      payment.save!
      item.update!(stock: item.stock)
      redirect_to root_path
    rescue
      if charge
        charge = Payjp::Charge.retrieve(charge.id)
        charge.refund
      end
      redirect_to new_item_payment_path
    end
  end

  private
  def payment_params
    params.permit(
      :item_id,
      :quantity,
    ).merge(buyer_id: current_user.id)
  end

end
