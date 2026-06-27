class Animal < ApplicationRecord
  belongs_to :shelter
  has_many :applications, dependent: :destroy
  validates :name, presence: true
  validates :species, presence: true
end
