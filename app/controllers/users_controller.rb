class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def search
    @users = User.search(params[:keyword])
    if user_signed_in?
      @user = current_user
      @my_items = Item.where(user_id: current_user.id).order('created_at DESC')
    end
  end

end
