# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :university

  validates :user_id, presence: true
  validates :university_id, presence: true
  validates :content, presence: true

  default_scope -> { order(created_at: :desc) }

  # Increases the report count for this comment
  def report
    self.report_count = if report_count.nil?
                          1
                        else
                          report_count + 1
                        end
  end
end
