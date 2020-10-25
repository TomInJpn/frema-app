require 'rails_helper'
describe Payment do

  before do
    @payment = build(:payment)
  end

  describe '決済機能' do
    context 'うまくいくとき' do
      it "必須項目（すべて）があれば購入できる" do
        expect(@payment).to be_valid
      end
      it "決済IDがあれば購入できる" do
        @payment.charge_id ="ch_4fa18c8cc30ead45c11be74f13fd4"
        expect(@payment).to be_valid
      end
      it "ユーザーIDがあれば購入できる" do
        @payment.user_id = build(:user)
        expect(@payment).to be_valid
      end
      it "アイテムIDがあれば購入できる" do
        @payment.item_id = build(:item)
        expect(@payment).to be_valid
      end
      it "購入数があれば購入できる" do
        @payment.quantity = 1
        expect(@payment).to be_valid
      end
    end

    context 'うまくいかないとき' do
      it "決済IDが無いと購入できない" do
        @payment.charge_id = ''
        @payment.valid?
        expect(@payment.errors.full_messages).to include("Chargeを入力してください")
      end
      it "購入数が無いと購入できない" do
        @payment.quantity = nil
        @payment.valid?
        expect(@payment.errors.full_messages).to include("Quantityを入力してください")
      end
      it "購入数が0で購入できない" do
        @payment.quantity = 0
        @payment.valid?
        expect(@payment.errors.full_messages).to include("Quantityは0より大きい値にしてください")
      end
      it "購入数がitem.stockを超えると購入できない" do
        @payment.quantity = 11
        @payment.valid?
        expect(@payment.errors.full_messages).to include("Quantity購入できるのは10個までです")
      end
    end
  end

end
