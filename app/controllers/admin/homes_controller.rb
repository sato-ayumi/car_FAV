class Admin::HomesController < ApplicationController
  def top
    @reports = Report.all
  end
end
