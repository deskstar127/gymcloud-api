module Services
module Seed

class GlobalPropertyUnit < BaseService

  def run
    add_units_to_global_properties
  end

  private

  def add_units_to_global_properties
    fixtures.map do |attrs|
      property = ::GlobalProperty.find_by!(symbol: attrs['symbol'])
      units = ::PropertyUnit.where(short_name: attrs['units'])
      default_unit = ::PropertyUnit.find_by(short_name: attrs['default'])
      save_unit = ::PropertyUnit.find_by(short_name: attrs['save'])
      property.default_unit = default_unit
      property.save_unit = save_unit
      property.property_units = units
      property.save
    end
  end

  def fixtures
    YAML.load_file(file_path)
  end

  def file_path
    'spec/fixtures/seed/global_property_units.yml'
  end

end

end
end
