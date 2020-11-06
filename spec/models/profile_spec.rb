require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'プロフィール登録' do
    before do
      @profile = FactoryBot.build(:profile)
    end

    context '登録がうまくいくとき' do
      it 'すべて空でも登録できる' do
        @profile.lastname = nil
        @profile.firstname = nil
        @profile.website = nil
        @profile.intro
        expect(@profile).to be_valid
      end
    end

    context '登録がうまくいかないとき' do
      it 'lastnameが21文字以上では登録できない' do
        @profile.lastname = Faker::Name.initials(number: 21)
        @profile.valid?
        expect(@profile.errors.full_messages).to include('姓は20文字以内で入力してください')
      end

      it 'firstnameが21文字以上では登録できない' do
        @profile.firstname = Faker::Name.initials(number: 21)
        @profile.valid?
        expect(@profile.errors.full_messages).to include('名は20文字以内で入力してください')
      end

      it 'introが201文字以上では登録できない' do
        @profile.intro = Faker::Name.initials(number: 101)
        @profile.valid?
        expect(@profile.errors.full_messages).to include('自己紹介は100文字以内で入力してください')
      end
    end

  end
end
