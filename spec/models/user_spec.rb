require 'rails_helper'
describe User do

  before do
    @user = build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "必須項目（すべて）があれば登録できる" do
        expect(@user).to be_valid
      end
      it "メールアドレスは@とドメインを含めば登録できる" do
        @user.email ="aaaaaa@aa.aaa"
        expect(@user).to be_valid
      end
      it "パスワードが半角英数のみ７文字以上で登録できる" do
        @user.password ="aaaaaa7"
        @user.password_confirmation ="aaaaaa7"
        expect(@user).to be_valid
      end
      it "ユーザー名字が全角で登録できる" do
        @user.family_name_kanji ="山田"
        expect(@user).to be_valid
      end
      it "ユーザー名前が全角で登録できる" do
        @user.first_name_kanji ="太郎"
        expect(@user).to be_valid
      end
      it "ユーザー名字かなが全角平仮名で登録できる" do
        @user.family_name_kana ="やまだ"
        expect(@user).to be_valid
      end
      it "ユーザー名前かなが全角平仮名で登録できる" do
        @user.first_name_kana ="たろう"
        expect(@user).to be_valid
      end
      it "生年月日が4-2-2桁で登録できる" do
        @user.birthday ="1975-01-01"
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "ニックネームが無いと登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nicknameを入力してください")
      end
      it "メールアドレスが無いと登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end
      it "メールアドレスが一意でないと登録できない" do
        another_user = create(:user)
        @user.email = another_user.email
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end
      it "メールアドレスは@とドメインが無ければ登録できない" do
        @user.email ="aaaaaaaaaaa"
        @user.valid?
        expect(@user.errors[:email]).to include("は不正な値です")
      end
      it "メールアドレスはドメインが無ければ登録できない" do
        @user.email ="aaaaa@aaaaaa"
        @user.valid?
        expect(@user.errors[:email]).to include("は不正な値です")
      end
      it "メールアドレスは@がが無ければ登録できない" do
        @user.email ="aaaaa.aaaaaa"
        @user.valid?
        expect(@user.errors[:email]).to include("は不正な値です")
      end
      it "パスワードが無いと登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it "パスワード確認用が無いと登録できない" do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("確認用パスワードは7文字以上で入力してください")
      end
      it "パスワードが半角英数のみ７文字以上であっても確認用と異なれば登録できない" do
        @user.password =              'aaaaaa7'
        @user.password_confirmation = 'bbbbbb7'
        @user.valid?
        expect(@user.errors.full_messages).to include("確認用パスワードとパスワードの入力が一致しません")
      end
      it "パスワードが6文字以下では登録できない" do
        @user.password =              'aaaaa6'
        @user.password_confirmation = 'aaaaa6'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは7文字以上で入力してください")
      end
      it "パスワードが数字のみでは登録できない" do
        @user.password =              '1234567'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it "パスワードが文字のみでは登録できない" do
        @user.password =              'abcdefg'
        @user.password_confirmation = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it "パスワードが半角英数以外の文字を含むと登録できない" do
        @user.password =              'abc-567'
        @user.password_confirmation = 'abc-567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end
      it "ユーザー名字が無いと登録できない" do
        @user.family_name_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kanjiを入力してください")
      end
      it "ユーザー名前が無いと登録できない" do
        @user.first_name_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanjiを入力してください")
      end
      it "ユーザー名字は全角でないと登録できない" do
        @user.family_name_kanji = "ﾔﾏﾀﾞ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kanjiは不正な値です")
      end
      it "ユーザー名前は全角でないと登録できない" do
        @user.first_name_kanji = "ﾀﾛｳ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanjiは不正な値です")
      end
      it "ユーザー名字かなが無いと登録できない" do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kanaを入力してください")
      end
      it "ユーザー名前かなが無いと登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanaを入力してください")
      end
      it "ユーザー名字かながひらがなでないと登録できない" do
        @user.family_name_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kanaは不正な値です")
      end
      it "ユーザー名前かながひらがなでないと登録できない" do
        @user.first_name_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanaは不正な値です")
      end
      it "ユーザー名字かなは全角でないと登録できない" do
        @user.family_name_kana = "ﾔﾏﾀﾞ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kanaは不正な値です")
      end
      it "ユーザー名前かなは全角でないと登録できない" do
        @user.first_name_kana = "ﾀﾛｳ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanaは不正な値です")
      end
      it "生年月日が無いと登録できない" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthdayを入力してください")
      end
      it "生年が無いと登録できない" do
        @user.birthday = '01-01'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthdayを入力してください")
      end
      it "生月が無いと登録できない" do
        @user.birthday = '2020-01'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthdayを入力してください")
      end
      it "生日が無いと登録できない" do
        @user.birthday = '2020-01'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthdayを入力してください")
      end
    end
  end

end