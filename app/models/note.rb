class Note < ApplicationRecord
  belongs_to :prospect, dependent: :destroy
  validates :detail, presence: true
end
