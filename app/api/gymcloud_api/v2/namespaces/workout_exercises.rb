module GymcloudAPI::V2
module Namespaces

class WorkoutExercises < Base

namespace :workout_exercises do

  desc 'Create Workout Exercise'
  params do
    requires :exercise_id, type: Integer
    requires :workout_id, type: Integer
    optional :workout_type, type: String, default: 'WorkoutTemplate',
      values: %w(WorkoutTemplate PersonalWorkout),
      desc: 'Workout Type'
    optional :note, type: String
    optional :position, type: Integer
    optional :order_name, type: String
  end
  post do
    attributes = filtered_params
    workout_exercise = ::WorkoutExercise.new(attributes)
    authorize!(:create, workout_exercise)
    workout_exercise.save!
    present(workout_exercise, with: Entities::WorkoutExercise)
  end

  params do
    requires :id, type: Integer, desc: 'Workout Exercise ID'
  end
  route_param :id do

    desc 'Read Workout Exercise'
    get do
      workout_exercise = ::WorkoutExercise.find(params[:id])
      authorize!(:read, workout_exercise)
      present(workout_exercise, with: Entities::WorkoutExercise)
    end

    desc 'Update Workout Exercise'
    params do
      optional :note, type: String
      optional :position, type: Integer
      optional :order_name, type: String
    end
    patch do
      workout_exercise = ::WorkoutExercise.find(params[:id])
      workout_exercise.assign_attributes(filtered_params)
      authorize!(:update, workout_exercise)
      workout_exercise.save!
      present(workout_exercise, with: Entities::WorkoutExercise)
    end

    desc 'Delete Workout Exercise'
    delete do
      workout_exercise = ::WorkoutExercise.find(params[:id])
      authorize!(:destroy, workout_exercise)
      workout_exercise.destroy
      present(workout_exercise, with: Entities::WorkoutExercise)
    end

  end

end

end

end
end
