# frozen_string_literal: true

module SessionsHelper
  # Logs a user in
  def log_in(user)
    session[:user_id] = user.id
  end

  # Retrieves the currently logged-in user (or nil if no one is logged in)
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Checks if a user is logged in
  def logged_in?
    !current_user.nil?
  end

  # Logs the current user out
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  delegate :admin?, to: :current_user

  delegate :mod?, to: :current_user

  # Gets the ID of the current user
  def user_id
    current_user.nil? ? nil : current_user.id
  end
end
