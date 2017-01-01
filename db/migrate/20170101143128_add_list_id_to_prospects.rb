class AddListIdToProspects < ActiveRecord::Migration[5.0]
  def change
    add_column :prospects, :list_id, :integer
  end
end
