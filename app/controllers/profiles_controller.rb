class ProfilesController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @profile = Profile.new
  end
  
  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def profile_params
    params.require(:profile).permit(:image, :lastname, :firstname, :website, :intro).merge(user_id: current_user.id)
  end

end
