# frozen_string_literal: true

class UniversitiesController < ApplicationController
  # Show a list of universities, filtered by name if the parameter 'q' is
  # passed to the controller
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def index
    @universities = []
    if params['mode'] == 'adv'
      name = params['name']
      city = params['city']
      state = params['state']
      zip = params['zip']
      size_min = params['size_min']
      size_max = params['size_max']
      acceptance_rate_min = params['acceptance_rate_min']
      acceptance_rate_max = params['acceptance_rate_max']
      sat_reading_min = params['sat_reading_min']
      sat_reading_max = params['sat_reading_max']
      sat_math_min = params['sat_math_min']
      sat_math_max = params['sat_math_max']
      act_min = params['act_min']
      act_max = params['act_max']
      cost_in_min = params['cost_in_min']
      cost_in_max = params['cost_in_max']
      cost_out_min = params['cost_out_min']
      cost_out_max = params['cost_out_max']
      @universities = University.adv_search(name, city, state, zip, size_min, size_max,
                                            acceptance_rate_min, acceptance_rate_max, sat_reading_min,
                                            sat_reading_max, sat_math_min, sat_math_max, act_min, act_max,
                                            cost_in_min, cost_in_max, cost_out_min, cost_out_max)
    else
      @universities = University.search(params['q'])
    end

    @result_size = @universities.size
    @universities = @universities.paginate(page: params['page'], per_page: 20).order('name ASC')
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  # Shows a specific university's information
  def show
    @university = University.find(params[:id])
  end
end
