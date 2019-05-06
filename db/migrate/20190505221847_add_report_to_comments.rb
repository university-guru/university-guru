class AddReportToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :report_count, :integer
  end
end
