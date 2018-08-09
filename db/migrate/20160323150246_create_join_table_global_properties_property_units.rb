class CreateJoinTableGlobalPropertiesPropertyUnits < ActiveRecord::Migration
  def change
    create_join_table :global_properties, :property_units do |t|
      t.index [:global_property_id, :property_unit_id],
        unique: true,
        name: 'global_property_unit_uniq_index'

      t.index [:property_unit_id, :global_property_id],
        name: 'global_property_unit_index'
    end
  end
end
