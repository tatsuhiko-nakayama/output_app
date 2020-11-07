class LikesController < ApplicationController

  def create
    @like = Like.create(user_id: current_user.id, item_id: params[:item_id])
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, item_id: params[:item_id])
    like.destroy
  end

end
