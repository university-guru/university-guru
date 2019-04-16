# frozen_string_literal: true

require 'csv'

define_singleton_method('fields') do
  { id: 'unitid',
    name: 'institution name',
    city: 'HD2017.City location of institution',
    state: 'HD2017.State abbreviation',
    zip_code: 'HD2017.ZIP code',
    school_site: 'HD2017.Institution\'s internet website address',
    student_count: 'DRVEF2017.Undergraduate enrollment',
    acceptance_rate: 'DRVADM2017.Percent admitted - total',
    q1_sat_reading: 'ADM2017.SAT Evidence-Based Reading and Writing 25th percentile score',
    q3_sat_reading: 'ADM2017.SAT Evidence-Based Reading and Writing 75th percentile score',
    q1_sat_math: 'ADM2017.SAT Math 25th percentile score',
    q3_sat_math: 'ADM2017.SAT Math 75th percentile score',
    q1_act: 'ADM2017.ACT Composite 25th percentile score',
    q3_act: 'ADM2017.ACT Composite 75th percentile score',
    cost_in: 'DRVIC2017.Total price for in-state students living on campus 2017-18',
    cost_out: 'DRVIC2017.Total price for out-of-state students living on campus 2017-18' }
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def create(row)
  # Add a University object to the database based on the JSON data
  # recieved from the data.gov API
  # NOTE: SAT/ACT scores are stored as quartiles (first quartile, third quartile)
  University.create(
    name: row[fields[:name]],
    city: row[fields[:city]],
    state: row[fields[:state]],
    zip_code: row[fields[:zip_code]],
    school_site: row[fields[:school_site]],
    student_count: row[fields[:student_count]],
    acceptance_rate: row[fields[:acceptance_rate]],
    q1_sat_reading: row[fields[:q1_sat_reading]],
    q3_sat_reading: row[fields[:q3_sat_reading]],
    q1_sat_math: row[fields[:q1_sat_math]],
    q3_sat_math: row[fields[:q3_sat_math]],
    q1_act: row[fields[:q1_act]],
    q3_act: row[fields[:q3_act]],
    cost_in: row[fields[:cost_in]],
    cost_out: row[fields[:cost_out]]
  )
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

csv_file = Rails.root.join('db', 'seeds', 'data.csv')
csv = CSV.read(csv_file.to_path, headers: true)

csv.each do |row|
  create(row)
end
