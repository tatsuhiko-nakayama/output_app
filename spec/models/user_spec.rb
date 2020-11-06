require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '登録がうまくいくとき' do
      it 'username,email,password(confirmation)が存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上の半角英数字であれば登録できる' do
        @user.password = 'test12'
        @user.password_confirmation = 'test12'
        expect(@user).to be_valid
      end
    end

    context '登録がうまくいかないとき' do
      it 'usernameが空では登録できない' do
        @user.username = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('ユーザー名を入力してください')
      end

      it '重複したusernameが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, username: @user.username)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('ユーザー名はすでに存在します')
      end

      it 'usernameが15文字以上であれば登録できない' do
        @user.username = Faker::Name.initials(number: 15)
        @user.valid?
        expect(@user.errors.full_messages).to include('ユーザー名は14文字以内で入力してください')
      end

      it 'usernameに半角英数字以外が含まれる場合は登録できない' do
        @user.username = 'testテスト'
        @user.valid?
        expect(@user.errors.full_messages).to include('ユーザー名は半角英数で入力してください')
      end

      it 'emailが空では登録できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスを入力してください')
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレスはすでに存在します')
      end

      it 'emailに@が含まれていなければ登録できない' do
        @user.email = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは不正な値です')
      end

      it 'passwordが空では登録できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'test1'
        @user.password_confirmation = 'test1'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordに半角英数字以外が含まれる場合は登録できない' do
        @user.password = 'test12テスト'
        @user.password_confirmation = 'test12テスト'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数のみで両方含めてください')
      end

      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
    end
  end
end
