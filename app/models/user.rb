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

  def add_favorite(id)
    favs_list = []
    favs_list = JSON.parse(favorites) if favorites.present?
    favs_list << id
    update_attribute(:favorites, JSON.generate(favs_list))
  end

  def remove_favorite(id)
    return if favorites.blank?

    favs_list = JSON.parse(favorites)
    favs_list.delete(id)
    update_attribute(:favorites, JSON.generate(favs_list))
  end

  def favorite?(id)
    if favorites.present?
      favs_list = JSON.parse(favorites)
      favs_list.include?(id)
    else
      false
    end
  end

  def favs
    favs_list = []
    favs_list = JSON.parse(favorites) if favorites.present?
    favs_list
  end
end
