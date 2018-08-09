module GymcloudAPI::V2
module Namespaces

class WorkoutTemplates < Base

namespace :workout_templates do

  desc 'Create Workout Template'
  params do
    requires :name, type: String
    optional :description, type: String
    optional :note, type: String
    optional :video_url, type: String
    optional :video_id, type: Integer
    optional :folder_id, type: Integer
    optional :is_public, type: Boolean, default: 'false'
    optional :is_visible, type: Boolean, default: 'true'
  end
  post do
    attributes = filtered_params_with(author: current_user, user: current_user)
    folder_id = current_user.folders.root.children
      .where(name: 'Workout Templates').pluck(:id).first
    workout_template = ::WorkoutTemplate.new(attributes)
    workout_template.folder_id = params[:folder_id] || folder_id
    authorize!(:create, workout_template)
    workout_template.save!
    present(workout_template, with: Entities::WorkoutTemplate)
  end

  desc 'Duplicate Workout'
  params do
    requires :ids, type: Array[Integer]
    optional :folder_ids, type: Array[Integer]
  end
  post '/duplicate' do
    old_workouts = ::WorkoutTemplate.with_deleted.find(params[:ids])
    workouts = []
    ActiveRecord::Base.transaction do
      old_workouts.each do |old_workout|
        authorize!(:read, old_workout)
        params[:folder_ids].each do |folder_id|
          service = Services::TemplateDuplicating::Workout.new(
            workout: old_workout,
            user: current_user,
            folder_id: folder_id
          )
          authorize!(:create, service.build)
          workouts << service.process.result
        end
      end
    end
    present(workouts, with: Entities::WorkoutTemplate)
  end

  params do
    requires :id, type: Integer, desc: 'WorkoutTemplate ID'
  end
  route_param :id do

    desc 'Read Workout Template'
    get do
      workout_template = ::WorkoutTemplate.find(params[:id])
      authorize!(:read, workout_template)
      present(workout_template, with: Entities::WorkoutTemplate, nested: true)
    end

    desc 'Update Workout Template'
    params do
      optional :name, type: String
      optional :description, type: String
      optional :note, type: String
      optional :video_url, type: String
      optional :video_id, type: Integer
      optional :folder_id, type: Integer
      optional :is_public, type: Boolean
      optional :is_visible, type: Boolean
    end
    patch do
      workout_template = ::WorkoutTemplate.find(params[:id])
      workout_template.assign_attributes(
        filtered_params_with(
          updated_at: workout_template.send(:current_time_from_proper_timezone)
        ))
      authorize!(:update, workout_template)
      workout_template.save!
      present(workout_template, with: Entities::WorkoutTemplate)
    end

    desc 'Delete Workout Template'
    delete do
      workout_template = ::WorkoutTemplate.find(params[:id])
      authorize!(:destroy, workout_template)
      workout_template.destroy
      present(workout_template, with: Entities::WorkoutTemplate)
    end

  end

end

end

end
end
