class CommentsController < ApplicationController
  def index
    @commented_user = User.find(params[:id])
    @items = @commented_user.commented_items.open.order('comments.created_at DESC').distinct.page(params[:page])
    if user_signed_in?
      @user = current_user
      @my_items = Item.where(user_id: current_user.id).order('created_at DESC')
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @item = @comment.item
    @comment.save
    @item.create_notification_comment(current_user, @comment.id)
    redirect_to item_path(@comment.item_id)
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to item_path(comment.item_id)
    else
      redirect_to item_path(comment.item.id)
    end
  end

  def comment_params
    params.require(:comment).permit(:message).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
