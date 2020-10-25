require 'rails_helper'
describe Address do

  before do
    @address = build(:address)
  end


  describe 'ユーザー新規登録/送付先住所' do
    context '新規登録がうまくいくとき' do
      it "必須項目があれば登録できる" do
        @address.apartment_name = ''
        @address.phone_number = ''
        expect(@address).to be_valid
      end

      it "郵便番号は半角数字3桁-4桁で登録できる" do
        @address.post_number = "123-1234"
        expect(@address).to be_valid
      end

      it "マンション名やビル名、そしてその部屋番号は任意" do
        @address.apartment_name = ''
        expect(@address).to be_valid
      end

      it "お届け先の電話番号は任意" do
        @address.phone_number = ''
        expect(@address).to be_valid
      end

      it "お届け先の電話番号は10桁で登録できる" do
        @address.phone_number = "0612341234"
        expect(@address).to be_valid
      end

      it "お届け先の電話番号は11桁で登録できる" do
        @address.phone_number = "09012341234"
        expect(@address).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      it "ユーザー名字が無いと登録できない" do
        @address.family_name_kanji = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Family name kanjiを入力してください")
      end

      it "ユーザー名前が無いと登録できない" do
        @address.first_name_kanji = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("First name kanjiを入力してください")
      end

      it "ユーザー名字かなが無いと登録できない" do
        @address.family_name_kana = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Family name kanaを入力してください")
      end

      it "ユーザー名前かなが無いと登録できない" do
        @address.first_name_kana = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("First name kanaを入力してください")
      end

      it "郵便番号が無いと登録できない" do
        @address.post_number = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Post numberを入力してください")
      end

      it "郵便番号は半角数字で無いと登録できない" do
        @address.post_number = "あ12-1234"
        @address.valid?
        expect(@address.errors.full_messages).to include("Post numberは不正な値です")
      end

      it "郵便番号は3桁-4桁で無いと登録できない" do
        @address.post_number = "1121-234"
        @address.valid?
        expect(@address.errors.full_messages).to include("Post numberは不正な値です")
      end

      it "都道府県が無いと登録できない" do
        @address.prefecture_id = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Prefectureを入力してください")
      end

      it "市区町村が無いと登録できない" do
        @address.city = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Cityを入力してください")
      end

      it "番地が無いと登録できない" do
        @address.block_number = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Block numberを入力してください")
      end

      it "お届け先の電話番号は9桁で登録できない" do
        @address.phone_number = "123456789"
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone numberは不正な値です")
      end
    end
  end
end