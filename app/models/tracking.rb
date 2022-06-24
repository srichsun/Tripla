class Tracking < ApplicationRecord
  belongs_to :user
  validates :duration, presence: true
end
