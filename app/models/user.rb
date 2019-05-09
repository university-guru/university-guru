# frozen_string_literal: true

class User < ApplicationRecord
  # Make sure emails are lower case in the database
  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, \
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }, \
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }

  has_many :add_requests, dependent: :destroy

  # Adds this university to the user's favorites list
  def add_favorite(id)
    favs_list = []
    favs_list = JSON.parse(favorites) if favorites.present?
    favs_list << id
    update_attribute(:favorites, JSON.generate(favs_list))
  end

  # Removes this university from the user's favorites list
  def remove_favorite(id)
    return if favorites.blank?

    favs_list = JSON.parse(favorites)
    favs_list.delete(id)
    update_attribute(:favorites, JSON.generate(favs_list))
  end

  # Checks if this university is on this user's favorites list
  def favorite?(id)
    if favorites.present?
      favs_list = JSON.parse(favorites)
      favs_list.include?(id)
    else
      false
    end
  end

  # Gets the list of university IDs on this user's favorites list
  def favs
    favs_list = []
    favs_list = JSON.parse(favorites) if favorites.present?
    favs_list
  end
end
