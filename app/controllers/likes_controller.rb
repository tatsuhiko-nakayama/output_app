class LikesController < ApplicationController
  before_action :set_item, only: [:create, :destroy]

  def index
    @items = current_user.liked_items.joins(:likes).order('likes.created_at DESC')
    if user_signed_in?
      @user = current_user
      @my_items = Item.where(user_id: current_user.id).order('created_at DESC')
    end
  end

  def create
    @like = Like.new(user_id: current_user.id, item_id: params[:item_id])
    @like.save
    @like_count = Like.where(item_id: @item.id).count
    redirect_to item_path(@item.id)
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, item_id: params[:item_id])
    like.destroy
    @like_count = Like.where(item_id: @item.id).count
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
