class AddGroupIdToImports < ActiveRecord::Migration[5.0]
  def change
    add_column :imports, :group_id, :integer
  end
end
