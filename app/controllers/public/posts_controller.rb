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
    if post_params[:images].present?
      post_params[:images].each do |image|
        result = Vision.images_analysis(image)
        if result == false
              flash.now[:alert] = "画像が不適切です。最初から入力して下さい。"
              render :new
              return
        end
      end
    end
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

    @posts = Post.all
    @posts = @posts.search(@keyword) if @keyword.present?
    @posts = @posts.by_genre(@by_genre) if @by_genre.present?
    @posts = @posts.by_home_country(@by_home_country) if @by_home_country.present?
    @posts = @posts.by_level(@by_level) if @by_level.present?
    @posts = @posts.by_originality(@by_originality) if @by_originality.present?
    @posts = @posts.latest if params[:order] == "latest"
    @posts = @posts.oldest if params[:order] == "oldest"
    @posts = @posts.most_favorite if params[:order] == "most_favorite"

  end

  #def index
    #@genres = Genre.all
    #if params[:genre_id].present?
      #@genre = @genres.find(params[:genre_id])
      #@posts = @genre.posts
    #elsif params[:keyword].present?
      #@posts = Post.joins(user: :home_country).where('posts.title LIKE :keyword OR posts.ingredient LIKE :keyword OR home_countries.name LIKE :keyword', keyword: "%#{params[:keyword]}%")
      #if @posts.empty?
        #flash.now[:notice] = "No results found"
      #end
    #else
      #@posts = Post.all
      #@posts = @posts.latest if params[:order] == "latest"
      #@posts = @posts.oldest if params[:order] == "oldest"
      #@posts = @posts.most_favorite if params[:order] == "most_favorite"
    #end
  #end

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
