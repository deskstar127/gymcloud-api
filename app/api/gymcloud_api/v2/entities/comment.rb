module GymcloudAPI::V2
module Entities

class Comment < Grape::Entity

  expose :id
  expose :title
  expose :created_at
  expose :updated_at
  expose :comment
  expose :commentable_id
  expose :commentable_type
  expose :user, using: Entities::User

end

end
end
