require "test_helper"

class WeatherServiceTest < ActiveSupport::TestCase
    test "returns a list of cities" do
        cities = WeatherService.get_cities
        assert_kind_of Array, cities, "Expected get_cities to return an array"
        assert_not_nil cities[0]["name"], "Expected cities.json to have a name"
        assert_not_nil cities[0]["lat"], "Expected cities.json to have latitudes"
        assert_not_nil cities[0]["lon"], "Expected cities.json to have longitudes"
        assert_not_nil cities[0]["pop"], "Expected cities.json to have popultions"
    end
    test "should fetch the weather" do
        response = WeatherService.fetch_weather 40.4167047, -3.7035825
        assert_not_nil response
    end
end
