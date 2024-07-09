class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @keyword = params[:keyword]
    @by_genre = params[:genre_id]
    @by_home_country = params[:home_country_id]
    @by_level = params[:level]
    @by_originality = params[:originality]

    @posts = Post.all.order(created_at: :desc)
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
    @post = Post.find(params[:id])
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
end
