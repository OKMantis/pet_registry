class Shelter < ApplicationRecord
  has_many :shelter_staff, dependent: :destroy
  has_many :staff_members, through: :shelter_staff, source: :user
  has_many :animals, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
