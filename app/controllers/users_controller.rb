class UsersController < ApplicationController
  before_action :correct_user_follower, only: :follower

  def show
    @user = User.find(params[:id])
    @items = @user.items.open.order('created_at DESC')
    @user_items = @user.items.order('created_at DESC')
  end

  def search
    @users = User.search(params[:keyword]).order('created_at DESC').page(params[:page])
    if user_signed_in?
      @user = current_user
      @my_items = Item.where(user_id: current_user.id).order('created_at DESC')
    end
  end

  def follow
    @follow_user = User.find(params[:id])
    @users = @follow_user.followings.order('relationships.created_at DESC')
    if user_signed_in?
      @user = current_user
      @my_items = Item.where(user_id: current_user.id).order('created_at DESC')
    end
  end
  
    
  def follower
    @follower_user = User.find(params[:id])
    @users = @follower_user.followers.order('relationships.created_at DESC')
    if user_signed_in?
      @user = current_user
      @my_items = Item.where(user_id: current_user.id).order('created_at DESC')
    end
  end

  private

  def correct_user_follower
    redirect_to root_path unless params[:id] = current_user.id
  end

end