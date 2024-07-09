class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :check_guest_user, only: [:edit, :update, :withdraw]


  def mypage
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(user_params)
       redirect_to my_page_path(@user), notice: "Successfully saved."
    else
       flash.now[:alert] = "Failed to save."
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
  
  def favorite
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def ensure_user
    @user = current_user
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to my_page_path
    end
  end
  
  def check_guest_user
    if current_user.email == "guest@example.com"
      redirect_to my_page_path, alert:"Access is not permitted."
    end
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :home_country_id)
  end
end
