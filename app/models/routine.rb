class Routine < ApplicationRecord
  belongs_to :user

  TYPES = %w[awake sleeping]
end
