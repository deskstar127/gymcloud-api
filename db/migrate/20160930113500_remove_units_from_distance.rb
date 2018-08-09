class RemoveUnitsFromDistance < ActiveRecord::Migration
  def up

    ft_unit_id = ::PropertyUnit.find_by(short_name: 'ft').id
    ::ExerciseProperty
      .joins { property_unit }
      .where { property_unit.short_name.in(['in', 'mm', 'cm']) }
      .update_all(property_unit_id: ft_unit_id)

    property = ::GlobalProperty.find_by(symbol: 'distance')
    property.property_units = ::PropertyUnit.where(short_name: [
      'ft', 'mi', 'm', 'km'
    ])

  end
end
