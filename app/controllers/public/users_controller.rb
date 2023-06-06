class Public::UsersController < ApplicationController
  
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    # @reviews = @user.reviews.page(params[:page]).reverse_order
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
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path
    end
  end
  
end
