module GymcloudAPI::V2
module Namespaces

class ProgramWorkouts < Base

namespace :program_workouts do

  desc 'Create Program Workout Template'
  params do
    requires :program_id, type: Integer
    optional :program_type, type: String, default: 'ProgramTemplate',
      values: %w(ProgramTemplate PersonalProgram),
      desc: 'Program Type'
    optional :workout_template_id, type: Integer
    optional :position, type: Integer
    optional :week_id, type: Integer
  end
  post do
    service_class =
      if params[:workout_template_id]
        Services::ProgramWorkout::Create
      else
        Services::ProgramWorkout::CreateNew
      end
    service = service_class.new(attrs: filtered_params, user: current_user)
    program_workout = ActiveRecord::Base.transaction do
      authorize!(:create, service.build_program_workout)
      service.process.result
    end
    present(program_workout, with: Entities::ProgramWorkout, nested: true)
  end

  params do
    requires :id, type: Integer, desc: 'Program Workout ID'
  end
  route_param :id do

    desc 'Read Program Workout Template'
    get do
      program_workout = ::ProgramWorkout.find(params[:id])
      authorize!(:read, program_workout)
      present(program_workout, with: Entities::ProgramWorkout, nested: true)
    end

    desc 'Update Program Workout Template'
    params do
      optional :note, type: String
      optional :position, type: Integer
      optional :week_id, type: Integer
    end
    patch do
      program_workout = ::ProgramWorkout.find(params[:id])
      program_workout.assign_attributes(filtered_params)
      authorize!(:update, program_workout)
      program_workout.save!
      present(program_workout, with: Entities::ProgramWorkout, nested: true)
    end

    desc 'Delete Program Workout Template'
    delete do
      program_workout = ::ProgramWorkout.find(params[:id])
      authorize!(:destroy, program_workout)
      program_workout = Services::ProgramWorkout::Destroy.!(
        program_workout: program_workout
      )
      present(program_workout, with: Entities::ProgramWorkout)
    end

    desc 'Duplicate Personal Program Workout'
    post '/duplicate' do
      program_workout = ::ProgramWorkout.find(params[:id])
      authorize!(:create, program_workout)

      workout = program_workout.workout
      new_program_workout = program_workout.dup
      new_program_workout.assign_attributes(
        workout: Services::PersonalDuplicating::Workout.!(workout: workout)
      )
      new_program_workout.save!

      present(new_program_workout, with: Entities::ProgramWorkout, nested: true)
    end

  end

end

end

end
end
