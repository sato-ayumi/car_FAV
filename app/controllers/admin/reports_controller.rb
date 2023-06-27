class Admin::ReportsController < ApplicationController
  before_action :set_report, only: [:show, :update, :destroy]

  def show
    @related_reports = @report.review.reports.where.not(id: @report.id).where(is_solved: false)
  end

  def update
    is_solved = params[:report][:is_solved]


    # 関連するレポートを取得（メインのレポートを除いて）
    related_reports = @report.review.reports.where.not(id: @report.id)

    ActiveRecord::Base.transaction do
      # メインのレポートのステータス更新
      @report.update(is_solved: is_solved)
      # 未対応から未対応への更新は無効化する
      if @report.is_solved == false
        redirect_to admin_report_path(@report), info: "無効な操作です。"
        return
      end
      # 関連するレポートのステータス更新
      related_reports.each do |report|
        report.update(is_solved: is_solved)
      end

      # 通知作成
      create_notification_for_report_update(@report)
      create_notification_for_related_reports_update(related_reports)
    end
    redirect_to admin_root_path, notice: "ステータスが更新されました。"
  end

  def destroy
    @report.destroy
    redirect_to admin_root_path, notice: "報告を削除しました。"
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  # メインのレポートを報告したユーザーへの通知作成
  def create_notification_for_report_update(report)
    Notification.create(user: report.user, target_type: 'Report', target_id: report.id, action: 'report_update')
  end

  # 関連したレポートたちのそれぞれのユーザーへの通知の作成
  def create_notification_for_related_reports_update(related_reports)
    related_reports.each do |report|
      # 既存の通知を確認
      existing_notification = Notification.find_by(user: report.user, target_type: 'Report', target_id: report.id, action: 'report_update')
      unless existing_notification
        Notification.create(user: report.user, target_type: 'Report', target_id: report.id, action: 'report_update')
      end
    end
  end

end
