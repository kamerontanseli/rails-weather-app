require "test_helper"

class SettingTest < ActiveSupport::TestCase
  test "is invalid if no user or theme passed" do
    setting = Setting.new
    assert setting.valid? == false
  end
  test "is valid if user passed" do
    user = User.create(email: "kam#{rand(1..100)}@mail.com", password: "#{rand(1..100)}_password_yo")
    setting = Setting.new(user_id: user.id)
    assert setting.valid?
  end
end
