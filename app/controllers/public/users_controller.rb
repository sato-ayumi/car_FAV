class Public::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def show
    if @user.is_deleted
      redirect_to reviews_path, info: "退会済みのユーザーです。"
    end
    @reviews = @user.reviews.page(params[:page]).reverse_order
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), success: "会員情報の更新が完了しました。"
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    #セッション情報を全て削除（セキュリティ面のリスク回避のため）
    reset_session
    redirect_to root_path, info: "退会処理を実行いたしました。"
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname, :profile_image, :email)
  end
  
  # 自分以外のユーザーの編集をさせないためのメソッド
  def is_matching_login_user
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
  # ゲストユーザーがユーザー情報を
  def ensure_guest_user
    if @user.nickname == "guestuser"
      redirect_to user_path(current_user) , info: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
