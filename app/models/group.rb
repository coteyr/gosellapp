class Group < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :users
  has_many :lists
  has_many :prospects, through: :lists
  has_many :imports
end
