class ItemsController < ApplicationController

  def index
    if current_user
      @user = User.find(current_user.id)
    end
    
  end

end
