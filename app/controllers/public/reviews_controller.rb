class Public::ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def show
    @review = Review.find(params[:id])
    @comments = @review.comments.reverse_order
    @comment = Comment.new
    @comment_reply = Comment.new
  end

  def index
    @reviews = Review.where(status: "published").page(params[:page]).reverse_order
  end
  
  def confirm
    @reviews = current_user.reviews.where(status: "draft").page(params[:page]).reverse_order
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    tag_list = params[:review][:tag_name].split("#")
    if @review.save
      @review.save_tag(tag_list)
      redirect_to review_path(@review), success: "投稿に成功しました。"
    else
      @reviews = Review.all
      render :index
    end
  end

  def edit
    @review = Review.find(params[:id])
    unless @review.user.id == current_user.id
       redirect_to reviews_path
    end
  end

  def update
    @review = Review.find(params[:id])
    unless @review.user.id == current_user.id
      edirect_to reviews_path
    end
    if @review.update(review_params)
      redirect_to review_path(@review), success: "投稿内容を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:review_image, :title, :body, :maker, :star, :status)
  end

end
