class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_post, only: [:edit, :update, :show, :destroy]
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "Successfully saved."
    else
      flash.now[:alert] = "Failed to save."
      render :new
    end
  end

  def index
    @keyword = params[:keyword]
    @by_genre = params[:genre_id]
    @by_home_country = params[:home_country_id]
    @by_level = params[:level]
    @by_originality = params[:originality]

    @posts = Post.page(params[:page]).per(20)
    @posts = @posts.search(@keyword) if @keyword.present?
    @posts = @posts.by_genre(@by_genre) if @by_genre.present?
    @posts = @posts.by_home_country(@by_home_country) if @by_home_country.present?
    @posts = @posts.by_level(@by_level) if @by_level.present?
    @posts = @posts.by_originality(@by_originality) if @by_originality.present?
    @posts = @posts.latest if params[:order] == "latest"
    @posts = @posts.oldest if params[:order] == "oldest"
    @posts = @posts.most_favorite if params[:order] == "most_favorite"
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
      flash.now[:alert] = "Failed to save."
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to my_page_path
  end

  def search
    @keyword = search_params[:keyword]
    @posts = Post.search(@keyword)
  end

  private

  def ensure_post
    @post = Post.find(params[:id])
  end

  def is_matching_login_user
    unless @post.user_id == current_user.id
      redirect_to posts_path
    end
  end

  def post_params
    params.require(:post).permit(:genre_id, :title, :body, :ingredient, :method, :level, :originality, :image)
  end

end
