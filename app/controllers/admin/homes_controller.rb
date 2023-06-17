class Admin::HomesController < ApplicationController
  def top
    @reports = Report.page(params[:page]).reverse_order
  end
end
