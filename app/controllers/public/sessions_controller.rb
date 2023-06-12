class Public::SessionsController < Devise::SessionsController
  
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to reviews_path, success: 'ゲストでログインしました。'
  end
  
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
end
