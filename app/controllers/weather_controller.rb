class WeatherController < ApplicationController
    def index
        city = CGI::unescape(params[:city])
        weather_data = Rails.cache.fetch("#{city}/weather_data", expires_in: 1.hours) do
            location = Location.where("lower(city) = ?", city).first
            WeatherService.fetch_weather(location.latitude, location.longitude)
        end
        render json: weather_data
    rescue
        render json: { error: "Location not found" }, status: :not_found
    end
end