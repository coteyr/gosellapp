class Prospect < ApplicationRecord
  belongs_to :user, required: true
  has_many :notes
  accepts_nested_attributes_for :notes, allow_destroy: true
  has_many :results
  accepts_nested_attributes_for :results, allow_destroy: true
  validates :company, presence: true
  validates :list_id, presence: true
  belongs_to :list
  scope :called, -> { where(called: true) }
  scope :canvassed, -> { where(canvassed: true) }
  scope :uncalled, -> { where.not(called: true) }
  scope :uncanvassed, -> { where.not(canvassed: true) }
  scope :unlocked, -> { where.not(locked_at: (DateTime.now - 30.seconds)..DateTime.now).or(where(locked_at: nil)) }

# the following 8 lines for exporting to csv
  def self.to_csv(fields = column_names, options = {})
    CSV.generate(options) do |csv|
      csv << fields
      all.each do |prospect|
        csv << prospect.attributes.values_at(*fields)
      end
    end
  end
end
