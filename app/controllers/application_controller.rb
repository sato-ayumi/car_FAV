class ApplicationController < ActionController::Base
  
  before_action :authenticate_admin!, if: :admin_url
  
  # Bootstrapでフラッシュメッセージ
  add_flash_types :success, :info, :warning, :danger
  
  private
  
  # URLにadminという文字でリクエストがあった場合
  def admin_url
    request.fullpath.include?("/admin")
  end
  
end
