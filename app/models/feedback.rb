class Feedback < ApplicationRecord
  scope :unviewed, -> { where(viewed: false) }
end