class Admin::HomesController < ApplicationController
  def top
    @reports = Report.all.reverse_order
  end
end
