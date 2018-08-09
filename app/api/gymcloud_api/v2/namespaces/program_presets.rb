module GymcloudAPI::V2
module Namespaces

class ProgramPresets < Base

namespace :program_presets do

  desc 'Get Preset List'
  get do
    presets = ::ProgramPreset.order(:id).all
    present(presets, with: Entities::ProgramPreset)
  end

  params do
    requires :id, type: Integer, desc: 'Program Preset ID'
  end
  route_param :id do

    desc 'Import Program Preset To Current User'
    params do
      requires :program_template_ids, type: Array[Integer]
    end
    post '/import' do
      preset = ::ProgramPreset.find(params[:id])
      authorize!(:import, preset)
      programs = Services::ProgramPreset::Import.!(
        user: current_user,
        program_preset: preset,
        program_template_ids: params[:program_template_ids]
      )
      present(programs, with: Entities::ProgramTemplate)
    end

  end

end

end

end
end
