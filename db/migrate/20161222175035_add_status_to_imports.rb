class AddStatusToImports < ActiveRecord::Migration[5.0]
  def change
    add_column :imports, :status, :string, default: 'pending'
  end
end
