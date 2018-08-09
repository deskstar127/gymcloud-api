module GymcloudAPI::V2
module Entities

class Folder < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :name
  expose :user_id
  expose :parent_id

end

end
end
