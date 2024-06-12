class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :check_guest_user


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

  def withdraw
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "Cancellation of membership has been executed."
    redirect_to root_path
  end
  

  private

  def ensure_user
    @user = current_user
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to posts_path
    end
  end
  
  def check_guest_user
    if current_user.email == "guest@example.com"
      redirect_to posts_path, alert:"Access is not permitted."
    end
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :home_country_id)
  end
end
