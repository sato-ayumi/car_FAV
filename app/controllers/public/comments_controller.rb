class Public::CommentsController < ApplicationController
  
  def create
    @review = Review.find(params[:review_id])
    # 投稿に紐づいたコメントの作成
    @comment = current_user.comments.new(comment_params)
    @comment.review_id = @review.id
    @comment.save
    redirect_to request.referer, success: "コメントに成功しました。"
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer, success: "コメントを削除しました。"
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment, :user_id, :review_id, :parent_id)
  end
  
end
