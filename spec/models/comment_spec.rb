require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメント登録' do
    before do
      @comment = FactoryBot.build(:comment)
    end

    context '登録がうまくいくとき' do
      it 'messageがあれば投稿できる' do
        expect(@comment).to be_valid
      end
    end

    context '登録がうまくいかないとき' do
      it 'messageが空では投稿できない' do
        @comment.message = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('コメントを入力してください')
      end

      it 'messageが10,001文字以上では登録できない' do
        @comment.message = Faker::Name.initials(number: 10_001)
        @comment.valid?
        expect(@comment.errors.full_messages).to include('コメントは10000文字以内で入力してください')
      end
    end
  end
end
