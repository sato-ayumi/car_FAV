class Public::UsersController < ApplicationController
  
  before_action :user_state, only: [:create]
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    if @user = User.find(params[:id])
       @user.update(user_params)
       redirect_to user_path(@user), success: "会員情報の更新が完了しました。"
    else
      render :edit
    end
  end
  
  def unsubscribe
  end
  
  def withdraw
    @user.update(is_deleted: true)
    #セッション情報を全て削除（セキュリティ面のリスク回避のため）
    reset_session
    redirect_to root_path, info: "退会処理を実行いたしました。"
  end
  
  private
  
  def user_params
    params.require(:user).permit(:nickname, :profile_image, :email)
  end
  
  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
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
