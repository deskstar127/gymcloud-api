module GymcloudAPI::V2
module Entities

class ClientGroupAssignment < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :name
  expose :pro_id
  expose :clients_count
  expose :assigned_count
  expose :is_assigned do |group|
    group.assigned_count == group.clients_count
  end

end

end
end
