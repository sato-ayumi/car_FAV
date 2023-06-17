class AddConstraintsToReports < ActiveRecord::Migration[6.1]
  def change
    change_column_null :reports, :description, false
  end
end
