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
      flash[:alert] = "Failed to save."
      render :new
    end
  end

  def index
    @genres = Genre.all
    if params[:genre_id].present?
      @genre = @genres.find(params[:genre_id])
      @posts = @genre.posts
    elsif params[:keyword].present?
      @posts = Post.joins(user: :home_country).where('posts.title LIKE :keyword OR posts.ingredient LIKE :keyword OR home_countries.name LIKE :keyword', keyword: "%#{params[:keyword]}%")
      if @posts.empty?
        flash.now[:notice] = "No results found"
      end
    else
      @posts = Post.all
    end
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
