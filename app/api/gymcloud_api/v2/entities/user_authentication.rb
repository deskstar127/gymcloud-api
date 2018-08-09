module GymcloudAPI::V2
module Entities

class UserAuthentication < Grape::Entity

  expose :id
  expose :email
  expose :provider do |auth|
    auth.authentication_provider.name
  end
  expose :created_at
  expose :updated_at

end

end
end
