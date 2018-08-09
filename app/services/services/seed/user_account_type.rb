module Services
module Seed

class UserAccountType < BaseSeedService

  private

  def klass
    ::UserAccountType
  end

  def file_path
    'spec/fixtures/seed/user_account_types.yml'
  end

end

end
end
