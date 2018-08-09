module Services
module Seed

class PropertyUnit < BaseSeedService

  private

  def klass
    ::PropertyUnit
  end

  def file_path
    'spec/fixtures/seed/property_units.yml'
  end

end

end
end
