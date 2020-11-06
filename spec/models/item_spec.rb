require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'アウトプット登録' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '登録がうまくいくとき' do
      it 'title,tagbody,body,url,status,category_idがあれば登録できる' do
        expect(@item).to be_valid
      end

      it 'tagbody,urlが空でも登録できる' do
        @item.tagbody = nil
        @item.url = nil
        expect(@item).to be_valid
      end
    end

    context '登録がうまくいかないとき' do
      it 'titleが空では登録できない' do
        @item.title = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('タイトルを入力してください')
      end

      it 'titleが41文字以上では登録できない' do
        @item.title = Faker::Name.initials(number: 41)
        @item.valid?
        expect(@item.errors.full_messages).to include('タイトルは40文字以内で入力してください')
      end

      it 'tagbodyが61文字以上では登録できない' do
        @item.tagbody = Faker::Name.initials(number: 61)
        @item.valid?
        expect(@item.errors.full_messages).to include('ハッシュタグは60文字以内で入力してください')
      end

      it 'bodyが空では登録できない' do
        @item.body = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('本文を入力してください')
      end

      it 'titleが100001文字以上では登録できない' do
        @item.body = Faker::Name.initials(number: 100_001)
        @item.valid?
        expect(@item.errors.full_messages).to include('本文は100000文字以内で入力してください')
      end

      it 'category_idが空では登録できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを入力してください')
      end
    end
  end
end
