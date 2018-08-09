class RemoveUnitFromGlobalProperty < ActiveRecord::Migration
  def change
    remove_column :global_properties, :unit, :string
    add_column :global_properties, :property_unit_id, :integer
  end
end
