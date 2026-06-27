class User < ApplicationRecord
  has_many :applications, dependent: :destroy
  has_many :shelter_staff, dependent: :destroy
  has_many :shelters, through: :shelter_staff
  validates :email, presence: true, uniqueness: true
end
