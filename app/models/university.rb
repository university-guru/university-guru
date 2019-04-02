# frozen_string_literal: true

class University < ApplicationRecord
  # Filter university list by name if a search term is given
  def self.search(search)
    if search.blank?
      all
    else
      where(['lower(name) like ?', "%#{search.downcase}%"]).all
    end
  end

  # Determines if this university has SAT score information
  def sat?
    !(q1_sat_reading.nil? || med_sat_reading.nil? \
      || q3_sat_reading.nil? || q1_sat_math.nil? || med_sat_math.nil? \
      || q3_sat_math.nil?)
  end

  # Determines if this university has ACT score information
  def act?
    !(q1_act.nil? || med_act.nil? || q3_act.nil?)
  end

  # Retrieves the school's URL prefixed with 'http://'
  def full_url
    if school_site.start_with? 'http://'
      school_site
    else
      "http://#{school_site}"
    end
  end
end
