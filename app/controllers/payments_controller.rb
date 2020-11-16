class PaymentsController < ApplicationController
  before_action :set_payment,only: [:new,:create]
  before_action :authenticate_user!

  def create
    begin
      item_stock = @item.stock - params[:quantity].to_i
      payment = Payment.new(payment_params)
      payment.payment = @item.price * params[:quantity].to_i
      if @item.shipment_fee_id == 2
        payment.payment += @postage[:"#{current_user.address.prefecture_id}"]
      end

      charge = Payjp::Charge.create(
        amount:   payment.payment,
        customer: Card.find_by(user_id: current_user.id).customer_id,
        currency: 'jpy',
      )

      payment.charge_id = charge.id
      payment.user_id   = @item.user_id

      payment.save!
      @item.update!(stock: item_stock)
    end
    redirect_to root_path

    rescue Payjp::PayjpError => e
      @payjp_err = e
      render :new

    rescue => e
      if charge
        charge = Payjp::Charge.retrieve(charge.id)
        charge.refund
      end
      @err = e
      render :new
  end

  private
  def payment_params
    params.permit(
      :item_id,
      :quantity,
    ).merge(buyer_id: current_user.id)
  end

  def set_payment
    @item = Item.find(params[:item_id])
    @shipment_fee = ShipmentFee.find(@item.shipment_fee_id)
    if current_user&.card
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(current_user.card.customer_id)
      @card = customer.cards.retrieve(current_user.card.card_id)
    end
    if @shipment_fee.id == 2
      @postage = Postage.find(@item.user.address.prefecture_id)
    end
  end

end
