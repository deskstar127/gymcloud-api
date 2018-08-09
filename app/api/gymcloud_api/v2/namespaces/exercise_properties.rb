module GymcloudAPI::V2
module Namespaces

class ExerciseProperties < Base

namespace :exercise_properties do

  desc 'Create Exercise Property'
  params do
    requires :personal_property_id, type: Integer
    requires :workout_exercise_id, type: Integer
    requires :property_unit_id, type: Integer
    optional :value, type: Float
    optional :value2, type: Float
    optional :position, type: Integer
  end
  post do
    exercise_property = ::ExerciseProperty.new(filtered_params)
    authorize!(:create, exercise_property)
    exercise_property.save!
    present(exercise_property, with: Entities::ExerciseProperty)
  end

  params do
    requires :id, type: Integer, desc: 'Exercise Property ID'
  end
  route_param :id do

    desc 'Read Exercise Property'
    get do
      exercise_property = ::ExerciseProperty.find(params[:id])
      authorize!(:read, exercise_property)
      present(exercise_property, with: Entities::ExerciseProperty)
    end

    desc 'Update Exercise Property'
    params do
      optional :value, type: Float
      optional :value2, type: Float
      optional :position, type: Integer
      optional :property_unit_id, type: Integer
      optional :personal_property_id, type: Integer
    end
    patch do
      exercise_property = ::ExerciseProperty.find(params[:id])
      exercise_property.assign_attributes(filtered_params)
      authorize!(:update, exercise_property)
      exercise_property.save!
      present(exercise_property, with: Entities::ExerciseProperty)
    end

    desc 'Delete Exercise Property'
    delete do
      exercise_property = ::ExerciseProperty.find(params[:id])
      authorize!(:destroy, exercise_property)
      exercise_property.destroy
      present(exercise_property, with: Entities::ExerciseProperty)
    end

  end

end

end

end
end
