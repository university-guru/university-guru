class RemoveMediansFromUniversities < ActiveRecord::Migration[5.2]
  def change
    remove_column :universities, :med_sat_math, :integer
    remove_column :universities, :med_sat_reading, :integer
    remove_column :universities, :med_act, :integer
  end
end
