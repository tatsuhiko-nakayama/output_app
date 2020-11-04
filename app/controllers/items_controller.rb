class ItemsController < ApplicationController

  def index
    if current_user
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
  end

  def destroy
  end

  def show
  end

  private

  def item_params
    params.require(:item).permit(:title, :tagbody, :body, :url, :status, :category_id).merge(user_id: current_user.id)
  end

end
