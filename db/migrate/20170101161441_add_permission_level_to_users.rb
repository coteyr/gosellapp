class AddPermissionLevelToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :permission_level, :string
  end
end
