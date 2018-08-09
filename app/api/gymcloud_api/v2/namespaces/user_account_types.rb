module GymcloudAPI::V2
module Namespaces

class UserAccountTypes < Base

namespace :user_account_types do

  desc 'Get User Account Type List'
  get do
    types = ::UserAccountType.order(:id).all
    present(types, with: Entities::UserAccountType)
  end

end

end

end
end
