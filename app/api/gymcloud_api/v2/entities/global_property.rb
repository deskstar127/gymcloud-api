module GymcloudAPI::V2
module Entities

class GlobalProperty < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :symbol
  expose :name
  expose :position

end

end
end
