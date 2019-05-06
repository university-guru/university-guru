# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = Comment.create(content: params[:comment][:content], \
                              user_id: params[:user_id], university_id: params[:university_id])
    flash[:danger] = 'Unable to comment!' unless @comment.save
    redirect_to request.referer || root_url
  end

  def report
    @comment = Comment.find(params[:id])
    @comment.report
    flash[:success] = 'Comment reported!' if @comment.save

    redirect_to request.referer || root_url
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = 'Comment deleted!'
    redirect_to request.referer || root_url
  end
end
