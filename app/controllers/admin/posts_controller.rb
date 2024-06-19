class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @genres = Genre.all
    if params[:genre_id]
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
    @post = Post.find(params[:id])
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
end
