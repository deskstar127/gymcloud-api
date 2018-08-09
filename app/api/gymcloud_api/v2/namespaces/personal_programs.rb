module GymcloudAPI::V2
module Namespaces

class PersonalPrograms < Base

namespace :personal_programs do

  desc 'Create Personal Program'
  params do
    requires :program_template_id, type: Integer, desc: 'Program Template ID'
    requires :person_id, type: Integer, desc: 'Assigned Person ID'
  end
  post do
    template = ::ProgramTemplate.find(params[:program_template_id])
    user = ::User.find(params[:person_id])
    service = Services::PersonalAssignment::Program.new(
      template: template,
      user: user
    )
    authorize!(:create, service.build_personal)
    program = service.process.result
    unless current_user == user
      HtmlMailer.delay.program_assigned(user.id, program.id)
    end
    program.create_activity(
      action: :create,
      owner: current_user,
      recipient: program.person
    )
    present(program, with: Entities::PersonalProgram)
  end

  params do
    requires :id, type: Integer, desc: 'Personal Program ID'
  end
  route_param :id do

    desc 'Read Personal Program'
    get do
      program = ::PersonalProgram.find(params[:id])
      authorize!(:read, program)
      present(program, with: Entities::PersonalProgram, nested: true)
    end

    desc 'Update Personal Program'
    params do
      optional :name, type: String
      optional :description, type: String
      optional :note, type: String
      optional :weeks_count, type: Integer
      optional :status, type: String, desc: 'Activity status',
                values: ::PersonalProgram.statuses.keys
    end
    patch do
      program = ::PersonalProgram.is_active.find(params[:id])
      program.assign_attributes(filtered_params)
      authorize!(:update, program)
      program.save!
      present program, with: Entities::PersonalProgram
    end

    desc 'Disable Personal Program'
    delete do
      program = ::PersonalProgram.is_active.find(params[:id])
      authorize!(:disable, program)
      program.update_attributes!(status: :inactive)
      present(program, with: Entities::PersonalProgram)
    end

  end

end

end

end
end
