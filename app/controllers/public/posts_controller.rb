class Public::PostsController < ApplicationController
  #before_action :authenticate_user!
  before_action :ensure_post, only: [:edit, :update, :show, :destroy]


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
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "Successfully saved."
    else
      flash[:alert] = "Failed to save."
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to my_page_path
  end



  private

  def ensure_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:genre_id, :title, :body, :ingredient, :method, :level, :originality, :image)
  end

end
