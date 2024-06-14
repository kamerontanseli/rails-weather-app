require "test_helper"

class LocationTest < ActiveSupport::TestCase
    test "validates presence of city, latitude, and longitude" do
        user = User.create(email: "kam#{rand(1..100)}@mail.com", password: "#{rand(1..100)}_password_yo")
        loc = Location.new
        assert (not loc.valid?)

        random_city = "London #{rand}"

        loc_two = Location.new(city: random_city, latitude: 20.3, longitude: 4.2, user_id: user.id)
        assert loc_two.valid?
    end
end
