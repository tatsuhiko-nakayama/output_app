class LikesController < ApplicationController
  before_action :set_item

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
