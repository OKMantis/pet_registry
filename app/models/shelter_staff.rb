class ShelterStaff < ApplicationRecord
  belongs_to :shelter
  belongs_to :user
  validates :user_id, uniqueness: { scope: :shelter_id }
end
