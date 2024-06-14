require "test_helper"

class LocationsControllerTest < ActionDispatch::IntegrationTest
  include Clearance::Testing

  setup do
    @user = User.create(email: "kam#{rand(1..100)}@mail.com", password: "#{rand(1..100)}_password_yo")
  end

  test "should get index and have default city loaded" do
    get root_url(as: @user)
    assert_equal "index", @controller.action_name
    assert_response :success
    assert_select ".weather-header__title", "Madrid"
  end

  test "should show city name in " do
    city = @user.locations.create(
      city: "London #{rand(1..100)}", 
      latitude: rand(1..100), 
      longitude: rand(1..100)
    )
    get locations_show_url(:city => city.city.downcase, as: @user)
    assert_equal "show", @controller.action_name
    assert_response :success
    assert_select ".weather-header__title", city.city
  end

  test "should remove city" do
    city = @user.locations.create(
      city: "London #{rand(1..100)}", 
      latitude: rand(1..100), 
      longitude: rand(1..100)
    )
    delete location_url(city, as: @user)
    assert_response :redirect
    get root_url(as: @user)
    assert_no_match city.city, @response.body
  end
end
