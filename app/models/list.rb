class List < ApplicationRecord
  validates :list_id, presence: true, uniqueness: {scope: :group_id}
  validates :group_id, presence: true
  has_many :prospects, dependent: :destroy
  belongs_to :group
end
