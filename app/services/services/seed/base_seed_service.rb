module Services
module Seed

class BaseSeedService < BaseService

  def run
    create_records_from_fixtures
  end

  private

  def create_records_from_fixtures
    fixtures.map do |fixture|
      attrs = fixture.dup
      klass \
        .create_with(symbol: attrs.delete(:symbol))
        .find_or_create_by(attrs)
    end
  end

  def fixtures
    @fixtures ||= YAML.load_file(file_path)
  end

  def klass
    nil
  end

  def file_path
    nil
  end

end

end
end
