# app/services/weather_service.rb
require 'httparty'

class WeatherService
  def self.get_cities
    file_path = Rails.root.join('app', 'assets', 'config', 'cities.json')    
    json_data = File.read(file_path)
    return JSON.parse(json_data)
  end
  def self.fetch_weather(latitude, longitude)
    url = "https://api.open-meteo.com/v1/forecast?latitude=#{latitude}&longitude=#{longitude}&current=temperature_2m"
    response = HTTParty.get(url)
    response.parsed_response
  rescue StandardError => e
    Rails.logger.error("Failed to fetch weather data: #{e.message}")
    nil
  end
end
