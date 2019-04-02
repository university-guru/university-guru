# frozen_string_literal: true

class UniversitiesController < ApplicationController
  # Show a list of universities, filtered by name if the parameter 'q' is
  # passed to the controller
  def index
    @universities = University.search(params['q']).paginate(page: params['page'], per_page: 20).order('name ASC')
  end

  # Shows a specific university's information
  def show
    @university = University.find(params[:id])
  end
end
