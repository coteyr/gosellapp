class AddGroupIdToProspects < ActiveRecord::Migration[5.0]
  def change
    add_column :prospects, :group_id, :integer
  end
end
