module GymcloudAPI::V2
module Namespaces

class ClientGroupAssignments < Base

  namespace :assignments do

    desc 'Get assigned workout templates to ClientGroup'
    get 'workout_templates' do
      client_group = ::ClientGroup.find(params[:id])
      authorize!(:read, client_group)
      results = ::WorkoutTemplate.assigned_to_group(client_group)
      present(results, with: Entities::WorkoutTemplate)
    end

    desc 'Get assigned program templates to ClientGroup'
    get 'program_templates' do
      client_group = ::ClientGroup.find(params[:id])
      authorize!(:read, client_group)
      results = ::ProgramTemplate.assigned_to_group(client_group)
      present(results, with: Entities::ProgramTemplate)
    end

    desc 'Assign template to ClientGroup'
    params do
      requires :template_id, type: Integer, desc: 'Template ID'
      requires :template_type,
        type: String,
        values: %w(WorkoutTemplate ProgramTemplate),
        desc: 'Template type'
    end
    post do
      client_group = ::ClientGroup.find(params[:id])
      template_class = "::#{params[:template_type]}".constantize
      template = template_class.find(params[:template_id])

      service_class = {
        WorkoutTemplate: Services::GroupAssignment::Workout,
        ProgramTemplate: Services::GroupAssignment::Program
      }[params[:template_type].to_sym]

      service = service_class.new(
        template: template,
        group: client_group,
        pro: current_user,
        create_activities: true
      )
      authorize!(:create, service.build_personal)
      service.process.result # return personal workouts/programs

      group = ClientGroup.with_assinged_count_for(template).find(params[:id])
      present(group, with: Entities::ClientGroupAssignment)
    end

    desc 'Unassign template from ClientGroup'
    params do
      requires :template_id, type: Integer, desc: 'Template ID'
      requires :template_type,
        type: String,
        values: %w(WorkoutTemplate ProgramTemplate),
        desc: 'Template type'
    end
    delete do
      client_group = ::ClientGroup.find(params[:id])
      template_type = params[:template_type].underscore
      template_class = "::#{params[:template_type]}".constantize
      # template = template_class.find(params[:template_id])
      template = template_class.find_by(original_id: params[:template_id])
      personal_class = {
        WorkoutTemplate: ::PersonalWorkout,
        ProgramTemplate: ::PersonalProgram
      }[params[:template_type].to_sym]

      personal_entities = personal_class
        .assigned_by(current_user)
        .where(template_type => template)
        .where(person_id: client_group.clients.pluck(:id).to_a)

      authorize!(:update, client_group)
      authorize!(:disable, personal_entities.first)
      personal_entities.each do |record|
        record.update_attributes!(status: :inactive)
      end
      template.destroy

      group = ClientGroup.with_assinged_count_for(template).find(params[:id])
      present(group, with: Entities::ClientGroupAssignment)
    end

  end

end

end
end
