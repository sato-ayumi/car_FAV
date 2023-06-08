class Public::CommentsController < ApplicationController
  
  def create
    @review = Review.find(params[:review_id])
    # 投稿に紐づいたコメントの作成
    @comment = current_user.comments.new(comment_params)
    @comment.review_id = @review.id
    # 返信コメントの作成
    # @comment_reply = @review.commnets.new
    @comment.save
      redirect_to request.referer
  end
  
  def destroy
    @review = Review.find(params[:review_id])
    @comment_reply = @review.comments.new
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referer
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment, :user_id, :review_id, :parent_id)
  end
  
end
