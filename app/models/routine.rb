class Routine < ApplicationRecord
  belongs_to :user
  validates :kind, presence: true

  TYPES = %w[awake sleeping]
end
