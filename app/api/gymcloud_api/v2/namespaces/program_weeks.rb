module GymcloudAPI::V2
module Namespaces

class ProgramWeeks < Base

namespace :program_weeks do

  desc 'Create Program Week'
  params do
    requires :name, type: String
    requires :position, type: Integer
    requires :program_id, type: Integer
    optional :program_type, type: String, default: 'ProgramTemplate',
      values: %w(ProgramTemplate PersonalProgram),
      desc: 'Program Type'
  end
  post do
    attributes = filtered_params
    program_week = ::ProgramWeek.new(attributes)
    authorize!(:create, program_week)
    program_week.save!
    present(program_week, with: Entities::ProgramWeek)
  end

  params do
    requires :id, type: Integer, desc: 'Program Week ID'
  end
  route_param :id do

    desc 'Read Program Week'
    get do
      program_week = ::ProgramWeek.find(params[:id])
      authorize!(:read, program_week)
      present(program_week, with: Entities::ProgramWeek)
    end

    desc 'Update Program Week'
    params do
      optional :name, type: String
      optional :position, type: Integer
    end
    patch do
      program_week = ::ProgramWeek.find(params[:id])
      program_week.assign_attributes(filtered_params)
      authorize!(:update, program_week)
      program_week.save!
      present(program_week, with: Entities::ProgramWeek)
    end

    desc 'Delete Program Week'
    delete do
      program_week = ::ProgramWeek.find(params[:id])
      authorize!(:destroy, program_week)
      program_week.destroy
      present(program_week, with: Entities::ProgramWeek)
    end

  end

end

end

end
end
