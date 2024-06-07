class Public::PostsController < ApplicationController
  #before_action :authenticate_user!
  before_action :ensure_post, only: [:edit, :update]
  
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to my_page_path, notice: "Successfully saved."
    else
      flash[:alert] = "Failed to save."
      render :new
    end
  end

  def index
  end

  def show
  end

  def edit
  end
  
  def ensure_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    params.require(:post).permit(:genre_id, :title, :body, :ingredient, :method, :level, :originality)
  end
  
end
