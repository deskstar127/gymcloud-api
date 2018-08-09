module GymcloudAPI::V2
module Entities

class ProgramPreset < Grape::Entity

  expose :id
  expose :name
  expose :program_template_ids
  expose :program_templates, using: Entities::ProgramTemplate

end

end
end
