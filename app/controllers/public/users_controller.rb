class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user
  
  def mypage
    @posts = @user.posts
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
       redirect_to my_page_path(@user), notice: "Successfully saved."
    else
       flash[:alert] = "Failed to save."
       render :edit
    end
  end

  def show
  end

  def confirm
  end
  
  private
  
  def ensure_user
    @user = current_user
  end
  
  def user_params
    params.require(:user).permit(:name, :nickname, :email, :home_country_id)
  end
end
