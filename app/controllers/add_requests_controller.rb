# frozen_string_literal: true

class AddRequestsController < ApplicationController
  # Loads the add request creation page, and redirects back if no ID was provided
  def new
    redirect_to(request.referer || root_url) if params[:university_id].blank?
    @request = AddRequest.new
    @university = University.find(params[:university_id])
  end

  # Creates the new add request using information provided by the user on the request page
  def create
    @request = AddRequest.new(params.require(:add_request).permit(:university_id, :content))
    @university = University.find(params[:add_request][:university_id])
    @request.user_id = current_user.id
    @request.status = false
    if @request.save
      flash[:success] = 'Request submitted!'
      redirect_to @university
    else
      render 'new'
    end
  end

  # Sets the status of a request so it no longer shows up in the dashboard
  def close
    @request = AddRequest.find(params[:id])
    @request.status = true
    flash[:success] = 'Request closed!' if @request.save

    redirect_to request.referer || root_url
  end
end
