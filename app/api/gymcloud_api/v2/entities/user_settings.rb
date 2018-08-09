module GymcloudAPI::V2
module Entities

class UserSettings < Grape::Entity

  expose :id,
    documentation: {
      desc: 'id',
      type: 'integer',
      required: true
    }

  expose :user_id,
    documentation: {
      desc: 'user id',
      type: 'integer',
      required: true
    }

  expose :user_account_type_id,
    documentation: {
      desc: 'account type id',
      type: 'integer'
    }

  expose :user_account_type_name,
    documentation: {
      desc: 'account type name',
      type: 'integer'
    }, if: -> (settings, _) { !settings.user_account_type_id.nil? } \
  do |settings|
    settings.user_account_type.name
  end

  expose :units_system,
    documentation: {
      desc: 'units system',
      type: 'string'
    }

  expose :tutorial_steps,
    documentation: {
      desc: 'finished tutorial steps',
      type: 'array'
    }

  expose :is_tutorial_finished,
    documentation: {
      desc: 'is tutorial finished',
      type: 'boolean'
    }

  expose :is_mobile_tutorial_finished,
    documentation: {
      desc: 'is mobile tutorial finished',
      type: 'boolean'
    }

  expose :is_presets_loaded,
    documentation: {
      desc: 'is presets loaded',
      type: 'boolean'
    }

end

end
end
