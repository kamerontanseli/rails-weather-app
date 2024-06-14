class LocationsController < ApplicationController
  before_action :require_login

  def index
    if current_user.locations.count < 1
      first_loc = Location.new(
        city: 'Madrid', 
        latitude: 40.4167047, 
        longitude: -3.7035825, 
        user_id: current_user.id
      )
      first_loc.save
    end
    @locations = current_user.locations.all
  end

  def show
    @location = current_user.locations.where("lower(city) = ?", params[:city]).first
    if not @location
      redirect_to root_path
    end
    @locations = current_user.locations.where("lower(city) != ?", params[:city]) || []
  end

  def cities
    results = WeatherService.get_cities
    if params[:search]
      results = results.select{ |item| (item["name"].downcase).include? params[:search].downcase }
    end
    render json: results[0..8]
  end

  def destroy
    current_user.locations.destroy(params[:id])
    redirect_to root_path
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def location_params
      params.require(:location).permit(:city, :latitude, :longitude, :user_id)
    end
end
