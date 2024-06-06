class Admin::GenresController < ApplicationController
  #before_action :authenticate_admin!
  before_action :ensure_genre, only: [:edit, :update]

  def index
    @genre = Genre.new
    @genres = Genre.all
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "Successfully saved."
    else
      @genres = Genre.all
      flash[:alert] = "Failed to save."
      render :index
    end
  end
  
  def update
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "Successfully saved."
    else
      flash[:alert] = "Failed to save."
      render :edit
    end
  end

  def edit
  end
  
  private
  
  def ensure_genre
    @genre = Genre.find(params[:id])
  end
  
  def genre_params
    params.require(:genre).permit(:name)
  end
end
