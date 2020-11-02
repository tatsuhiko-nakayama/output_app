class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @profile = Profile.where(user_id: current_user.id)
  end

end
