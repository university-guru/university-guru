# frozen_string_literal: true

class StaticPagesController < ApplicationController
  # Loads the moderator dashboard
  def moderator
    @comments = Comment.where(['report_count > ?', 0]).order('report_count DESC')
  end

  # Loads the administrator dashboard
  def administrator
    @requests = AddRequest.where(['status = ?', false]).order('created_at ASC')
  end

  # Loads the compare page, and adds a university to it if an ID is supplied
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def compare
    unless params[:university].nil?
      array = cookies[:compare]
      array = if array.nil?
                []
              else
                JSON.parse(array)
              end

      array << params[:university] unless array.include?(params[:university])
      cookies[:compare] = JSON.generate(array)
    end

    array = JSON.parse(cookies[:compare])
    @universities = []
    array.each do |id|
      @universities << University.find(id)
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  # Removes a university from the comparison list
  # rubocop:disable Metrics/AbcSize
  def remove_compare
    unless params[:university].nil?
      array = cookies[:compare]
      unless array.nil?
        array = JSON.parse(array)
        array.delete(params[:university]) if array.include?(params[:university])
        cookies[:compare] = JSON.generate(array)
      end
    end

    redirect_to controller: :static_pages, action: :compare
  end
  # rubocop:enable Metrics/AbcSize

  # Loads the help page
  def help; end
end
