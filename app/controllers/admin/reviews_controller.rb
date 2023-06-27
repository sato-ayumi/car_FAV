class Admin::ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]

  def index
    @reviews = Review.where(status: "published")
    # 絞り込みによる検索があった場合
    if params[:makers].present?
      makers = params[:makers].reject(&:blank?)
      @reviews = @reviews.where(maker: makers)
    end
    @reviews_counts = @reviews.count
    @reviews = @reviews.page(params[:page]).reverse_order
  end

  def show
    begin
      @review = Review.find(params[:id])
      @comments = @review.comments.reverse_order
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_reviews_path, info: "投稿が見つかりませんでした。"
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to admin_review_path(@review), success: "投稿内容を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to admin_user_path(@review.user), success: "投稿を削除しました。"
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:review_image, :title, :body, :maker)
  end

end
