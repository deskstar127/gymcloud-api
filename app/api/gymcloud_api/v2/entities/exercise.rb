module GymcloudAPI::V2
module Entities

class Exercise < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :name
  expose :description
  expose :video_url
  expose :video_id
  expose :folder_id
  expose :is_public
  expose :user_id
  expose :author_id
  expose :author_full_name do |exercise|
    exercise.author.user_profile.full_name
  end
  expose :author,
    if: {nested: true},
    using: Entities::User

end

end
end
