class List < ApplicationRecord
  validates :list_id, presence: true, uniqueness: true
  has_many :prospects, dependent: :destroy
end
