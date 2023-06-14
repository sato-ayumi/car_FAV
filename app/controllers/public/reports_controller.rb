class Public::ReportsController < ApplicationController
  
  def new
    @report = Report.new
  end
  
  def create
    @report = Report.new(report_params)
    if @report.save
      redirect_to 
end
