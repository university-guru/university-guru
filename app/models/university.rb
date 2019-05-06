# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
class University < ApplicationRecord
  has_many :comments, dependent: :destroy

  # rubocop:disable Style/ClassVars
  @@states = [
    'Alabama',
    'Alaska',
    'America Samoa',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut',
    'Delaware',
    'District of Columbia',
    'Federated States Of Micronesia',
    'Florida',
    'Georgia',
    'Guam',
    'Hawaii',
    'Idaho',
    'Illinois',
    'Indiana',
    'Iowa',
    'Kansas',
    'Kentucky',
    'Louisiana',
    'Maine',
    'Marshall Islands',
    'Maryland',
    'Massachusetts',
    'Michigan',
    'Minnesota',
    'Mississippi',
    'Missouri',
    'Montana',
    'Nebraska',
    'Nevada',
    'New Hampshire',
    'New Jersey',
    'New Mexico',
    'New York',
    'North Carolina',
    'North Dakota',
    'Ohio',
    'Oklahoma',
    'Oregon',
    'Palau',
    'Pennsylvania',
    'Puerto Rico',
    'Rhode Island',
    'South Carolina',
    'South Dakota',
    'Tennessee',
    'Texas',
    'Utah',
    'Vermont',
    'Virgin Island',
    'Virginia',
    'Washington',
    'West Virginia',
    'Wisconsin',
    'Wyoming'
  ]
  # rubocop:enable Style/ClassVars
  cattr_reader :states

  # Filter university list by name if a search term is given
  def self.search(search)
    if search.blank?
      all
    else
      where(['lower(name) like ?', "%#{search.downcase}%"]).all
    end
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  # rubocop:disable Metrics/ParameterLists
  def self.adv_search(name, city, state, zip, size_min, size_max,
                      acceptance_rate_min, acceptance_rate_max, sat_reading_min,
                      sat_reading_max, sat_math_min, sat_math_max, act_min, act_max,
                      cost_in_min, cost_in_max, cost_out_min, cost_out_max)
    query = ''
    params = []

    if name.present?
      query += "#{'AND ' if query.present?}lower(name) like ? "
      params << "%#{name.downcase}%"
    end

    if city.present?
      query += "#{'AND ' if query.present?}lower(city) like ? "
      params << "%#{city.downcase}%"
    end

    if state.present?
      query += "#{'AND ' if query.present?}lower(state) like ? "
      params << "%#{state.downcase}%"
    end

    if zip.present?
      query += "#{'AND ' if query.present?}lower(zip_code) like ? "
      params << "%#{zip.downcase}%"
    end

    if size_min.present?
      query += "#{'AND ' if query.present?}student_count >= ? "
      params << size_min
    end

    if size_max.present?
      query += "#{'AND ' if query.present?}student_count <= ? "
      params << size_max
    end

    if acceptance_rate_min.present?
      query += "#{'AND ' if query.present?}acceptance_rate >= ? "
      params << acceptance_rate_min
    end

    if acceptance_rate_max.present?
      query += "#{'AND ' if query.present?}acceptance_rate <= ? "
      params << acceptance_rate_max
    end

    if sat_reading_min.present?
      query += "#{'AND ' if query.present?}q3_sat_reading > ? "
      params << sat_reading_min
    end

    if sat_reading_max.present?
      query += "#{'AND ' if query.present?}q1_sat_reading < ? "
      params << sat_reading_max
    end

    if sat_math_min.present?
      query += "#{'AND ' if query.present?}q3_sat_math > ? "
      params << sat_math_min
    end

    if sat_math_max.present?
      query += "#{'AND ' if query.present?}q1_sat_math < ? "
      params << sat_math_max
    end

    if act_min.present?
      query += "#{'AND ' if query.present?}q3_act > ? "
      params << act_min
    end

    if act_max.present?
      query += "#{'AND ' if query.present?}q1_act < ? "
      params << act_max
    end

    if cost_in_min.present?
      query += "#{'AND ' if query.present?}cost_in >= ? "
      params << cost_in_min
    end

    if cost_in_max.present?
      query += "#{'AND ' if query.present?}cost_in <= ? "
      params << cost_in_max
    end

    if cost_out_min.present?
      query += "#{'AND ' if query.present?}cost_out >= ? "
      params << cost_out_min
    end

    if cost_out_max.present?
      query += "#{'AND ' if query.present?}cost_out <= ? "
      params << cost_out_max
    end

    if query.empty?
      all
    else
      where([query, params].flatten).all
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  # rubocop:enable Metrics/ParameterLists

  # Determines if this university has SAT reading score information
  def sat_reading?
    !(q1_sat_reading.nil? || q3_sat_reading.nil?)
  end

  # Determines if this university has SAT math score information
  def sat_math?
    !(q1_sat_math.nil? || q3_sat_math.nil?)
  end

  # Determines if this university has ACT score information
  def act?
    !(q1_act.nil? || q3_act.nil?)
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
# rubocop:enable Metrics/ClassLength
