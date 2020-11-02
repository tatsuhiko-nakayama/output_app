class ProfilesController < ApplicationController
 
  def edit
    @user = User.find(current_user.id)
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:image, :lastname, :firstname, :website, :intro).merge(user_id: current_user.id)
  end

end
