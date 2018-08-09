module GymcloudAPI::V2
module Namespaces

class UserSettings < Base

namespace :user_settings do

  desc 'Create User Settings' do
    success Entities::UserSettings
  end
  params do
    optional :user_account_type_id, type: Integer
    optional :units_system, type: String,
      values: ::UserSettings.units_systems.keys,
      default: 'imperial'
    optional :tutorial_steps, type: Array[String]
    optional :is_tutorial_finished, type: Boolean, default: 'false'
    optional :is_presets_loaded, type: Boolean, default: 'false'
  end
  post do
    attributes = filtered_params_with(user: current_user)
    settings = ::UserSettings.new(attributes)
    authorize!(:create, settings)
    settings.save!
    present(settings, with: Entities::UserSettings)
  end

  params do
    requires :id, type: Integer, desc: 'User Profile ID'
  end
  route_param :id do

    desc 'Fetch User Settings' do
      success Entities::UserSettings
    end
    get do
      settings = ::UserSettings.find(params[:id])
      authorize!(:read, settings)
      present(settings, with: Entities::UserSettings)
    end

    desc 'Update User Settings' do
      success Entities::UserSettings
    end
    params do
      optional :user_account_type_id, type: Integer
      optional :units_system, type: String,
        values: ::UserSettings.units_systems.keys
      optional :tutorial_steps, type: Array[String]
      optional :is_tutorial_finished, type: Boolean
      optional :is_mobile_tutorial_finished, type: Boolean
      optional :is_presets_loaded, type: Boolean
    end
    patch do
      settings = ::UserSettings.find(params[:id])
      settings.assign_attributes(filtered_params)
      authorize!(:update, settings)
      settings.save!
      present(settings, with: Entities::UserSettings)
    end

  end

end

end

end
end
