module GymcloudAPI::V2
module Entities

class ProgramAssignees < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :person_id
  expose :program_template_version

end

end
end
