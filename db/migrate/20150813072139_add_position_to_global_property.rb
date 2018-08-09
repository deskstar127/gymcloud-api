class AddPositionToGlobalProperty < ActiveRecord::Migration
  def change
    add_column :global_properties, :position, :integer
    add_index :global_properties, :position, unique: true
  end
end
