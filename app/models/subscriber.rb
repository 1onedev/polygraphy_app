class Subscriber < ApplicationRecord
  scope :unviewed, -> { where(viewed: false) }
end
