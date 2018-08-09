module Services
module Seed

class GlobalProperty < BaseSeedService

  private

  def create_records_from_fixtures
    fixtures.map do |fixture|
      attrs = fixture.dup
      next if klass.find_by(symbol: attrs['symbol'])
      property = klass \
        .create_with(symbol: attrs.delete(:symbol))
        .find_or_create_by(attrs)
      Services::GlobalProperties::Add.!(global_property: property)
      property
    end
  end

  def klass
    ::GlobalProperty
  end

  def file_path
    'spec/fixtures/seed/global_properties.yml'
  end

end

end
end
