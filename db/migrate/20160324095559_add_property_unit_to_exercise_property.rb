class AddPropertyUnitToExerciseProperty < ActiveRecord::Migration

  def change
    add_column :exercise_properties, :property_unit_id, :integer

    ExerciseProperty.find_in_batches(batch_size: 1000) do |properties|
      properties.each do |ex_prop|
        default_unit = ex_prop.personal_property.default_unit
        ex_prop.property_unit = default_unit
        ex_prop.save
      end
    end
  end

end
