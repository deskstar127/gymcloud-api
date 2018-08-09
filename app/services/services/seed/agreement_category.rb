module Services
module Seed

class AgreementCategory < BaseSeedService

  private

  def klass
    ::AgreementCategory
  end

  def file_path
    'spec/fixtures/seed/agreement_categories.yml'
  end

end

end
end
