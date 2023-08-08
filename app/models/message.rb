class Message < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :admin, optional: true

  scope :unviewed, -> { where(viewed: false) }
end