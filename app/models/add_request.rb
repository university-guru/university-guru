# frozen_string_literal: true

class AddRequest < ApplicationRecord
  belongs_to :user
  belongs_to :university
end
