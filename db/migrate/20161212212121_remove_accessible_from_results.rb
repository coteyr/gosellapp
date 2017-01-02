class RemoveAccessibleFromResults < ActiveRecord::Migration[5.0]
  def change
    remove_column :results, :accessible, :boolean
  end
end
