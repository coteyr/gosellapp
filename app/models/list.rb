class List < ApplicationRecord
  validates :list_id, presence: true, uniqueness: true
end
