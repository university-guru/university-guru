# frozen_string_literal: true

require 'net/http'
require 'json'

# These methods determine which years should be used for retreving data
# from the data.gov API (they should be the most recent year for which
# the specific data is available)
define_singleton_method('admissions_year') { 2016 }
define_singleton_method('student_year') { 2016 }
define_singleton_method('cost_year') { 2016 }
# This method defines which fields should be requested from the data.gov API
# for each college/university
define_singleton_method('fields') do
  { id: 'id',
    name: 'school.name',
    city: 'school.city',
    state: 'school.state',
    zip_code: 'school.zip',
    school_site: 'school.school_url',
    student_count: "#{student_year}.student.size",
    acceptance_rate: "#{admissions_year}.admissions.admission_rate.overall",
    q1_sat_reading: "#{admissions_year}.admissions.sat_scores.25th_percentile.critical_reading",
    med_sat_reading: "#{admissions_year}.admissions.sat_scores.midpoint.critical_reading",
    q3_sat_reading: "#{admissions_year}.admissions.sat_scores.75th_percentile.critical_reading",
    q1_sat_math: "#{admissions_year}.admissions.sat_scores.25th_percentile.math",
    med_sat_math: "#{admissions_year}.admissions.sat_scores.midpoint.math",
    q3_sat_math: "#{admissions_year}.admissions.sat_scores.75th_percentile.math",
    q1_act: "#{admissions_year}.admissions.act_scores.25th_percentile.cumulative",
    med_act: "#{admissions_year}.admissions.act_scores.midpoint.cumulative",
    q3_act: "#{admissions_year}.admissions.act_scores.75th_percentile.cumulative",
    cost_in: "#{cost_year}.cost.tuition.in_state",
    cost_out: "#{cost_year}.cost.tuition.out_of_state" }
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def create(result)
  # Add a University object to the database based on the JSON data
  # recieved from the data.gov API
  # NOTE: SAT/ACT scores are stored as quartiles (first quartile, median, third quartile)
  University.create(
    name: result[fields[:name]],
    city: result[fields[:city]],
    state: result[fields[:state]],
    zip_code: result[fields[:zip_code]],
    school_site: result[fields[:school_site]],
    student_count: result[fields[:student_count]],
    acceptance_rate: result[fields[:acceptance_rate]],
    q1_sat_reading: result[fields[:q1_sat_reading]],
    med_sat_reading: result[fields[:med_sat_reading]],
    q3_sat_reading: result[fields[:q3_sat_reading]],
    q1_sat_math: result[fields[:q1_sat_math]],
    med_sat_math: result[fields[:med_sat_math]],
    q3_sat_math: result[fields[:q3_sat_math]],
    q1_act: result[fields[:q1_act]],
    med_act: result[fields[:med_act]],
    q3_act: result[fields[:q3_act]],
    cost_in: result[fields[:cost_in]],
    cost_out: result[fields[:cost_out]]
  )
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

# Base API request information
uri = URI('https://api.data.gov/ed/collegescorecard/v1/schools')
api_key = { api_key: ENV['EDU_API_KEY'] }
params = { _fields: fields.values.join(',') }
uri.query = URI.encode_www_form(params.merge(api_key))

response = Net::HTTP.get_response(uri)
# If response is a success (i.e. 200 OK), continue parsing the results
if response.is_a?(Net::HTTPSuccess)
  json_hash = JSON.parse(response.body)

  # Determine how many results are returned per JSON page and calculate
  # the minimum API calls required
  total_items = json_hash['metadata']['total']
  per_page_items = json_hash['metadata']['per_page']
  iterations_req = (total_items.to_f / per_page_items).ceil

  # Request each JSON page from the API
  (0...iterations_req).each do |i|
    page = { page: i }
    uri.query = URI.encode_www_form(params.merge(api_key).merge(page))

    response = Net::HTTP.get_response(uri)
    # If response is a success (i.e. 200 OK), parse the JSON data and begin
    # constructing University objects
    next unless response.is_a?(Net::HTTPSuccess)

    json_hash = JSON.parse(response.body)

    # For each result in the array, create a new University  object
    json_hash['results'].each do |result|
      create(result)
    end
  end
end
