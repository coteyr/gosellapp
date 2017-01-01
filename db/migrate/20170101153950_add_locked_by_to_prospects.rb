class AddLockedByToProspects < ActiveRecord::Migration[5.0]
  def change
    add_column :prospects, :locked_by_id, :integer
  end
end
