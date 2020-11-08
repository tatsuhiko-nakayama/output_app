class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to item_path(@comment.item_id)
    else
      redirect_to item_path(@comment.item_id)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to item_path(comment.item_id)
    else
      redirect_to item_path(comment.item.id)
    end
  end

  def cooment_params
    params.require(:comment).permit(:message).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
