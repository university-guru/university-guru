# frozen_string_literal: true

class InitSchema < ActiveRecord::Migration[5.2]
  def up
    # These are extensions that must be enabled in order to support this database
    enable_extension 'plpgsql'
    create_table 'universities' do |t|
      t.string 'name'
      t.integer 'student_count'
      t.text 'street_address'
      t.string 'city'
      t.string 'state'
      t.integer 'q1_act'
      t.integer 'med_act'
      t.integer 'q3_act'
      t.float 'acceptance_rate'
      t.float 'cost_in'
      t.float 'cost_out'
      t.integer 'institution_type'
      t.integer 'year_founded'
      t.text 'school_site'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.string 'zip_code'
      t.integer 'q1_sat_reading'
      t.integer 'med_sat_reading'
      t.integer 'q3_sat_reading'
      t.integer 'q1_sat_math'
      t.integer 'med_sat_math'
      t.integer 'q3_sat_math'
      t.index ['id'], unique: true
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration, 'The initial migration is not revertable'
  end
end
