class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  
  def index
    @users = User.page(params[:page]).reverse_order
  end

  def show
    @reviews = @user.reviews.page(params[:page]).reverse_order
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), success: "会員情報の更新が完了しました。"
    else
      render :edit
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:nickname, :profile_image, :email, :is_deleted)
  end
  
end
