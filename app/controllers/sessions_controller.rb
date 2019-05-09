# frozen_string_literal: true

class SessionsController < ApplicationController
  # Takes the user to the login page
  def new; end

  # Signs the user in and allows them to maintain login between pages
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination!'
      render 'new'
    end
  end

  # Logs the user out
  def destroy
    log_out
    redirect_to root_url
  end
end
