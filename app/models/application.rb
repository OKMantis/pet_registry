class Application < ApplicationRecord
  belongs_to :user
  belongs_to :animal
  validates :status, inclusion: { in: %w[pending approved rejected] }
end
