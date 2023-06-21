class Public::SessionsController < Devise::SessionsController
  
  before_action :user_state, only: [:create]
  
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
  
  #退会しているか判断するメソッド
  def user_state
    # 入力されたemailからアカウントを１件取得
    @user = User.find_by(email: params[:user] [:email])
    # アカウントを取得できなかった場合、このメソッドを修了する
    return if !@user
    # 取得したアカウントのパスワードと入力されたパスワードが一致しているか かつ　is_deletedカラムがtrue(退会済み)判別
    if @user.valid_password?(params[:user] [:password] ) && (@user.is_deleted == true )
      redirect_to new_user_registration_path, notice: "退会済みです。再度ご登録をしてご利用ください"
    end
  end
  
end
