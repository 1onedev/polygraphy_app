class Cooperation < ApplicationRecord
  scope :unviewed, -> { where(viewed: false) }
end