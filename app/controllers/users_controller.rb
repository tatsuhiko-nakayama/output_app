class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def search
    @users = User.search(params[:keyword])
    if user_signed_in?
      @user = User.find(current_user.id)
      @my_items = Item.where(user_id: current_user.id).order('created_at DESC')
    end
  end

end
