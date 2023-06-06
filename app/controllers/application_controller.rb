class ApplicationController < ActionController::Base
  
  before_action :authenticate_admin!, if: :admin_url
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :customer_state, only: [:create]
  
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
  
  #退会しているか判断するメソッド
  def user_state
    # 入力されたemailからアカウントを１件取得
    @user = User.find_by(email: params[:user] [:email])
    # アカウントを取得できなかった場合、このメソッドを修了する
    return if !@user
    # 取得したアカウントのパスワードと入力されたパスワードが一致しているか かつ　is_deletedカラムがtrue(退会済み)判別
    if @user.valid_password?(params[:user] [:password] ) && (@customer.is_deleted == true )
      redirect_to new_user_registration_path, notice: "退会済みです。再度ご登録をしてご利用ください"
    end
  end
  
end
