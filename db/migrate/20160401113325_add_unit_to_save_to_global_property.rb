class AddUnitToSaveToGlobalProperty < ActiveRecord::Migration
  def change
    add_column :global_properties, :save_property_unit_id, :integer
  end
end
