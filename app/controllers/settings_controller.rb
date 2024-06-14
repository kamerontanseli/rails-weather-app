class SettingsController < ApplicationController
  before_action :require_login

  def index
    redirect_to edit_setting_path(@setting)
  end

  def edit
  end

  def update
    @setting.update(setting_params)
    if @setting.save
      flash[:alert] = "Settings updated"
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  private
  def setting_params
    params.require(:setting).permit(:theme)
  end
end
