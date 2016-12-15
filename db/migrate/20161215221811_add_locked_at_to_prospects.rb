class AddLockedAtToProspects < ActiveRecord::Migration[5.0]
  def change
    add_column :prospects, :locked_at, :datetime
  end
end
