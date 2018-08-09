class RemoveGrams < ActiveRecord::Migration
  def up

    ::ExerciseProperty
      .joins { personal_property.global_property.save_unit }
      .where { personal_property.global_property.save_unit.short_name == 'g' }
      .update_all('value = (value/1000), value2 = (value2/1000)')

    kg_unit_id = ::PropertyUnit.find_by(short_name: 'kg').id
    ::ExerciseProperty
      .joins { property_unit }
      .where { property_unit.short_name == 'g' }
      .update_all(property_unit_id: kg_unit_id)

    lbs_unit_id = ::PropertyUnit.find_by(short_name: 'lbs').id
    ::ExerciseProperty
      .joins { property_unit }
      .where { property_unit.short_name == 'oz' }
      .update_all(property_unit_id: lbs_unit_id)

    properties = ::GlobalProperty
      .joins { default_unit }
      .joins { save_unit }
      .where do
        default_unit.short_name.in(['g', 'oz']) |
        save_unit.short_name.in(['g', 'oz'])
      end
    properties.update_all(
      property_unit_id: kg_unit_id,
      save_property_unit_id: kg_unit_id
    )

    ::ExerciseResultItem
      .joins { exercise_property.property_unit }
      .where { exercise_property.property_unit.short_name.in(['kg', 'lbs']) }
      .update_all('value = (value/1000)')

    ::PropertyUnit.destroy_all(short_name: ['g', 'oz'])

  end
end
