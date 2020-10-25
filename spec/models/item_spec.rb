require 'rails_helper'
describe Item do

  before do
    @item = build(:item)
  end


  describe '商品登録/画像登録' do

    context '新規登録がうまくいくとき' do
      it "全項目があれば登録できる" do
        expect(@item).to be_valid
      end

      it "商品名が１文字で登録できる" do
        @item.name = "#{"あ" * 1}"
        expect(@item).to be_valid
      end

      it "商品名が４０文字で登録できる" do
        @item.name = "#{"あ" * 40}"
        expect(@item).to be_valid
      end

      it "カテゴリがあれば登録できる" do
        @item.category = build(:category)
        expect(@item).to be_valid
      end

      it "ブランドは任意" do
        @item.brand = ''
        expect(@item).to be_valid
      end

      it "商品の状態があれば登録できる" do
        @item.condition_id = 1
        expect(@item).to be_valid
      end

      it "商品の説明が１文字で登録できる" do
        @item.description = "#{"あ" * 1}"
        expect(@item).to be_valid
      end

      it "商品の説明が１０００文字で登録できる" do
        @item.description = "#{"あ" * 1000}"
        expect(@item).to be_valid
      end

      it "配送料の負担があれば登録できる" do
        @item.shipment_fee_id = 1
        expect(@item).to be_valid
      end

      it "配送元の地域があれば登録できる" do
        @item.prefecture_id = 1
        expect(@item).to be_valid
      end

      it "販売個数が０以上９９９９以下であれば登録できる" do
        @item.stock = 10
        expect(@item).to be_valid
      end

      it "販売個数が０で登録できる" do
        @item.stock = 0
        expect(@item).to be_valid
      end

      it "販売個数が９９９９であれば登録できる" do
        @item.stock = 9999
        expect(@item).to be_valid
      end

      it "販売価格が３００以上９，９９９，９９９以下であれば登録できる" do
        @item.price = 5000
        expect(@item).to be_valid
      end

      it "販売価格が３００で登録できる" do
        @item.price = 300
        expect(@item).to be_valid
      end

      it "販売価格が９，９９９，９９９で登録できる" do
        @item.price = 9999999
        expect(@item).to be_valid
      end

    end

    context '新規登録がうまくいかないとき' do

      it "画像が無ければ登録できない" do
        @item.images.clear
        @item.valid?
        expect(@item.errors.full_messages).to include("Imagesを入力してください")
      end

      it "画像が１１枚以上で登録できない" do
        @item.images.clear
        @item.images << build_list(:image,11)
        @item.valid?
        expect(@item.errors.full_messages).to include("Imagesは10枚以下にしてください")
      end

      it "商品名が無ければ登録できない" do
        @item.name = "#{"あ" * 0}"
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it "商品名が４１文字以上で登録できない" do
        @item.name = "#{"あ" * 41}"
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名は40文字以内で入力してください")
      end

      it "カテゴリが無ければ登録できない" do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end

      it "商品の状態が無ければ登録できない" do
        @item.condition_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end

      it "商品の説明が無ければ登録できない" do
        @item.description = "#{"あ" * 0}"
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it "商品の説明が１００１文字で登録できない" do
        @item.description = "#{"あ" * 1001}"
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明は1000文字以内で入力してください")
      end

      it "配送料の負担が無ければ登録できない" do
        @item.shipment_fee_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end

      it "配送元の地域が無ければ登録できない" do
        @item.prefecture_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefectureを入力してください")
      end

      it "販売個数が無ければ登録できない" do
        @item.stock = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("在庫を入力してください")
      end

      it "販売個数が0未満で登録できない" do
        @item.stock = -1
        @item.valid?
        expect(@item.errors.full_messages).to include("在庫は0以上の値にしてください")
      end

      it "販売個数が１００００個で登録できない" do
        @item.stock = 10000
        @item.valid?
        expect(@item.errors.full_messages).to include("在庫は9999以下の値にしてください")
      end

      it "販売価格が無ければ登録できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end

      it "販売価格が300未満で登録できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は300以上の値にしてください")
      end

      it "販売価格が１０，０００，０００円で登録できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は9999999以下の値にしてください")
      end

    end

  end
end