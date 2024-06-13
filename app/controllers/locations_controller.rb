class LocationsController < ApplicationController
  require 'httparty'
  before_action :require_login

  def fetch_from_cache(key)
    self.class.cache_store[key] ||= yield
  end

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
      redirect_to "/"
    end
    @locations = current_user.locations.where("lower(city) != ?", params[:city])
  end

  def weather
    weather_data = Rails.cache.fetch("#{params[:city]}/weather_data", expires_in: 1.hours) do
      location = Location.where("lower(city) = ?", params[:city]).first
      WeatherService.fetch_weather(location.latitude, location.longitude)
    end
    render json: weather_data
  end

  def destroy
    current_user.locations.destroy(params[:id])
    redirect_to "/"
  end

  def new
    @location = Location.new
    @cities = WeatherService.get_cities
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to "/"
    else
      @cities = WeatherService.get_cities
      render :new, status: :unprocessable_entity
    end
  end

  private
    def location_params
      params.require(:location).permit(:city, :latitude, :longitude, :user_id)
    end
end
