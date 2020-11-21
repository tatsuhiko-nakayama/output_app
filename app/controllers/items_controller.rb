class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show]
  before_action :set_user_items, only: [:index, :tag, :category, :search]
  before_action :correct_user_new, only: :new
  before_action :correct_user_edit, only: :edit

  def index
    @items = Item.open.order('created_at DESC').page(params[:page])
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

  def tag
    @tag = Tag.find_by(name: params[:name])
    @items = @tag.items.open.order('created_at DESC')
  end

  def category
    @item = Item.find_by(category_id: params[:id])
    @items = Item.open.where(category_id: params[:id]).order('created_at DESC')
  end

  def search
    @items = Item.open.search(params[:keyword]).order('created_at DESC')
  end

  def like
    @liked_item = Item.find(params[:id])
    @users = @liked_item.liked_users.order('likes.created_at DESC')
    if user_signed_in?
      @user = current_user
      @my_items = Item.where(user_id: current_user.id).order('created_at DESC')
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :tagbody, :body, :url, :status, :category_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_user_items
    if user_signed_in?
      @user = current_user
      @my_items = Item.where(user_id: current_user.id).order('created_at DESC')
    end
  end

  def correct_user_new
    redirect_to new_user_registration_path unless user_signed_in?
  end

  def correct_user_edit
    redirect_to root_path unless user_signed_in? && @item.user.id == current_user.id
  end
end
