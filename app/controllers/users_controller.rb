# frozen_string_literal: true

class UsersController < ApplicationController
  # Loads the sign-up page
  def new
    @user = User.new
  end

  # Adds a new user to the database and logs them in automatically
  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    if @user.save
      log_in @user
      flash[:success] = 'Registration successful!'
      redirect_to @user
    else
      render 'new'
    end
  end

  # Loads the user page
  def show
    @user = User.find(params[:id])
    @comments = Comment.where(['user_id = ?', @user.id])
    @favorites = @user.favs
    @requests = AddRequest.where(['user_id = ? AND status = ?', @user.id, false])
  end
end
