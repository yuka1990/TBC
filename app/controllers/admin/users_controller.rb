class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    if params[:search].present?
      @users = User.where('name LIKE :search OR nickname LIKE :search', search: "%#{params[:search]}%")
    else
    @users = User.all
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path, notice: "Successfully saved."
    else
      @posts = @user.posts
      flash[:alert] = "Failed to save."
      render :show
    end
  end
      

  def edit
    @user = User.find(params[:id])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:is_active)
  end
  
end
