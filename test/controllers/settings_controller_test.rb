require "test_helper"

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email: "kam#{rand(1..100)}@mail.com", password: "#{rand(1..100)}_password_yo")
    @setting = Setting.create(user_id: @user.id)
  end

  test "should get index" do
    get settings_url(as: @user)
    assert_response :redirect
  end

  test "should get edit" do
    get edit_setting_url(@setting, as: @user)
    assert_response :success
  end
end
