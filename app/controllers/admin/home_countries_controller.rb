class Admin::HomeCountriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_home_country, only: [:edit, :update]
  
  
  def index
    @home_country = HomeCountry.new
    @home_countries = HomeCountry.all
  end
  
  def create
    @home_country = HomeCountry.new(home_country_params)
    if @home_country.save
      redirect_to admin_home_countries_path, notice: "Successfully saved."
    else
      @home_countries = HomeCountry.all
      flash[:alert] = "Failed to save."
      render :index
    end
  end
  
  def update
    if @home_country.update(home_country_params)
      redirect_to admin_home_countries_path, notice: "Successfully saved."
    else
      flash[:alert] = "Failed to save."
      render :edit
    end
  end

  def edit
  end
  
  private
  
  def ensure_home_country
    @home_country = HomeCountry.find(params[:id])
  end
  
  def home_country_params
    params.require(:home_country).permit(:name , :image)
  end
end
