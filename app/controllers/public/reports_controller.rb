class Public::ReportsController < ApplicationController
  
  def new
    @review = Review.find(params[:review_id])
    @report = Report.new
  end
  
  def create
    @review = Review.find(params[:review_id])
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to root_path, info: "ご報告ありがとうございます。確認ができましたら通知でお知らせ致します。"
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
