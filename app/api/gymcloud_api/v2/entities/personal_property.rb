module GymcloudAPI::V2
module Entities

class PersonalProperty < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :person_id
  expose :display_name, as: :name
  expose :position
  expose :is_visible
  expose :global_property, using: Entities::GlobalProperty
  expose :default_unit, using: Entities::PropertyUnit
  expose :save_unit, using: Entities::PropertyUnit
  expose :property_units, using: Entities::PropertyUnit

end

end
end
