module GymcloudAPI::V2
module Entities

class ClientGroup < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :name
  expose :pro_id
  expose :clients,
    if: {nested: true},
    using: Entities::User
  expose :clients_count do |group|
    group.clients.count
  end

end

end
end
