require 'rails_helper'
describe Card do

  before do
    @card = build(:card)
  end

  describe 'カード登録' do
    context 'うまくいくとき' do
      it "必須項目（すべて）があれば登録できる" do
        expect(@card).to be_valid
      end
      it "ユーザーIDがあれば登録できる" do
        @card.user_id = build(:user)
        expect(@card).to be_valid
      end
      it "カスタマーIDがあれば登録できる" do
        @card.customer_id ="cus_3f3dd31a5e4988871900b59ce437"
        expect(@card).to be_valid
      end
      it "カードIDがあれば登録できる" do
        @card.card_id ="car_67148c02a56939e882b13c218bf7"
        expect(@card).to be_valid
      end
    end

    context 'うまくいかないとき' do
      it "user_idが一意でないと登録できない" do
        @another_card = create(:card)
        @card.user_id = @another_card.user_id
        @card.valid?
        expect(@card.errors.full_messages).to include("Userはすでに存在します")
      end
      it "カスタマーIDが無いと登録できない" do
        @card.customer_id = ''
        @card.valid?
        expect(@card.errors.full_messages).to include("Customerを入力してください")
      end
      it "カードIDが無いと登録できない" do
        @card.card_id = ''
        @card.valid?
        expect(@card.errors.full_messages).to include("Cardを入力してください")
      end
    end
  end

end
