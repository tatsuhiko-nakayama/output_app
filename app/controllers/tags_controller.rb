class TagsController < ApplicationController

  def search
    @tags = Tag.search(params[:keyword]).joins(:item_tags).group(:tag_id).order('count(item_id)desc')

    if user_signed_in?
      @user = current_user
      @my_items = Item.where(user_id: current_user.id).order('created_at DESC')
    end
  end

end
