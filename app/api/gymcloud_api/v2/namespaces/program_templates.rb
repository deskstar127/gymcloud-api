module GymcloudAPI::V2
module Namespaces

class ProgramTemplates < Base

namespace :program_templates do

  desc 'Create Program Template'
  params do
    requires :name, type: String
    optional :description, type: String
    optional :note, type: String
    optional :folder_id, type: Integer
    optional :is_public, type: Boolean, default: 'false'
  end
  post do
    attributes = filtered_params_with(author: current_user, user: current_user)
    folder_id = current_user.folders.root.children
      .where(name: 'Program Templates').pluck(:id).first
    program_template = ::ProgramTemplate.new(attributes)
    program_template.folder_id = params[:folder_id] || folder_id
    authorize!(:create, program_template)
    program_template.save!
    present(program_template, with: Entities::ProgramTemplate)
  end

  desc 'Duplicate Program(s)'
  params do
    requires :ids, type: Array[Integer]
    optional :folder_ids, type: Array[Integer]
  end
  post '/duplicate' do
    old_programs = ::ProgramTemplate.find(params[:ids])
    programs = []
    ActiveRecord::Base.transaction do
      old_programs.each do |old_program|
        authorize!(:read, old_program)
        params[:folder_ids].each do |folder_id|
          service = Services::TemplateDuplicating::Program.new(
            program: old_program,
            user: current_user,
            folder_id: folder_id
          )
          authorize!(:create, service.build)
          programs << service.process.result
        end
      end
    end
    present(programs, with: Entities::ProgramTemplate)
  end

  params do
    requires :id, type: Integer, desc: 'ProgramTemplate ID'
  end
  route_param :id do

    desc 'Read Program Template'
    get do
      program_template = ::ProgramTemplate.find(params[:id])
      authorize!(:read, program_template)
      present(program_template, with: Entities::ProgramTemplate, nested: true)
    end

    desc 'Update Program Template'
    params do
      optional :name, type: String
      optional :description, type: String
      optional :note, type: String
      optional :weeks_count, type: Integer
      optional :folder_id, type: Integer
      optional :is_public, type: Boolean
    end
    patch do
      program_template = ::ProgramTemplate.find params[:id]
      program_template.assign_attributes(filtered_params)
      authorize!(:update, program_template)
      program_template.save!
      present(program_template, with: Entities::ProgramTemplate, nested: true)
    end

    desc 'Delete Program Template'
    delete do
      program_template = ::ProgramTemplate.find(params[:id])
      authorize!(:destroy, program_template)
      program_template.destroy
      present(program_template, with: Entities::ProgramTemplate)
    end

  end

end

end

end
end
