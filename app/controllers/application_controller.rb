class ApplicationController < ActionController::Base
  
  before_action :authenticate_admin!, if: :admin_url
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # Bootstrapでフラッシュメッセージ
  add_flash_types :success, :info, :warning, :danger
  
  private
  
  # URLにadminという文字でリクエストがあった場合
  def admin_url
    request.fullpath.include?("/admin")
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
  
end
