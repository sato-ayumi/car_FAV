class Public::ReportsController < ApplicationController
  
  def create
    @review = Review.find(params[:review_id])
    @report = current_user.reports.new(report_params)
    @report.review_id = @review.id
    if @report.save
      redirect_to review_path(@review), info: "ご報告ありがとうございます。確認ができましたら通知でお知らせ致します。"
    else
      flash[:danger] = "送信に失敗しました"
      render :new
    end
    
  end
  
  private
  
  def report_params
    params.require(:report).permit(:user_id, :review_id, :description)
  end
  
end
