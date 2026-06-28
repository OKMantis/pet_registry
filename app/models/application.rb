class Application < ApplicationRecord
  belongs_to :user
  belongs_to :animal
  validates :status, inclusion: { in: %w[pending approved rejected] }
  # Rails validation → friendly form error
  # DB unique index → actual safety net against race conditions
  validates :user_id, uniqueness: {
    scope: :animal_id,
    message: "already has an application for this animal"
  }

  scope :pending, -> { where(status: "pending") }
  scope :approved, -> { where(status: "approved") }
  scope :rejected, -> { where(status: "rejected") }
end
