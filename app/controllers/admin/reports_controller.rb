class Admin::ReportsController < ApplicationController
  

  def show
    @report = Report.find(params[:id])
  end
  
  def update
    @report = Report.find(params[:id])
    is_solved = params[:report][:is_solved]
    
    # 関連するレポートを取得
    related_reports = @report.review.reports
    
    ActiveRecord::Base.transaction do
      # メインのレポートのステータス更新
      @report.update(is_solved: is_solved)
      # 関連するレポートのステータス更新
      related_reports.update_all(is_solved: is_solved)
      
      # 通知作成
      create_nitification_for_report_update(@report, is_solved)
      create_notification_for_related_reports_update(related_reports, is_solved)
    end
    
    redirect_to root_path, success: "ステータスが更新されました。"
  
  end
    
  private
  
  #  メインのレポートを報告したユーザーへの通知作成
  def create_notification_for_report_update(report, is_solved)
    Notification.create(user_id: report.user_id, target_type: 'Report', target_id: report.id, action: 'report_update', is_solved: is_solved)
  end
  
  # 関連したレポートたちのそれぞれのユーザーへの通知の作成
  def create_notification_for_related_reports_update(reports, is_solved)
    reports.each do |report|
      Notification.create(user_id: report.user_id, target_type: 'Report', target_id: report.id, action: 'report_update', is_solved: is_solved)
    end
  end
  
end
