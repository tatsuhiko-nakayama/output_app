class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show]
  before_action :block_new, only: :new
  before_action :block_edit, only: :edit

  def index
    if user_signed_in?
      @user = User.find(current_user.id)
      @my_items = Item.where(user_id: current_user.id).order('created_at DESC')
    end

    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.order('created_at DESC')
    @like_count = Like.where(item_id: @item.id).count
  end

  private

  def item_params
    params.require(:item).permit(:title, :tagbody, :body, :url, :status, :category_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def block_new
    redirect_to new_user_registration_path unless user_signed_in?
  end

  def block_edit
    redirect_to root_path unless user_signed_in? && @item.user.id == current_user.id
  end
end
