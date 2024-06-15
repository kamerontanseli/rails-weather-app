class ApplicationController < ActionController::Base
  include Clearance::Controller

  before_action :get_or_create_settings

  private

  def get_or_create_settings
    if current_user
      @setting = current_user.setting
      if not @setting
        @setting = current_user.setting.create(user_id: current_user.id)
      end
      return @setting
    end
  end
end
