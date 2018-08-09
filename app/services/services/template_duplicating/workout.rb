module Services
module TemplateDuplicating

class Workout < BaseService

  def run
    duplicate
  end

  def input_params
    [:workout, :user, :folder_id, :is_visible]
  end

  def defaults
    {folder_id: nil, is_visible: true}
  end

  def build
    ::WorkoutTemplate.new(prepare_attributes)
  end

  private

  def duplicate
    new_workout = ::WorkoutTemplate.create!(prepare_attributes)

    @workout.workout_exercises.each do |we|
      duplicate_workout_exercise(we, new_workout)
    end

    new_workout
  end

  def prepare_attributes
    to_include = %w(name description note video_url)
    @workout.attributes.slice(*to_include).merge(
      is_public: false,
      is_visible: @is_visible,
      folder_id: prepare_folder,
      author: @workout.author,
      user: @user,
      original: @workout.original || @workout
    )
  end

  def prepare_folder
    @folder_id ||=
      ::Folder.find_by(name: 'Workout Templates', user: @user).id
  end

  def duplicate_workout_exercise(workout_exercise, new_workout)
    new_workout_exercise = workout_exercise.dup
    new_workout_exercise.assign_attributes(workout: new_workout)
    new_workout_exercise.save!
    workout_exercise.exercise_properties.each do |exercise_property|
      duplicate_exercise_property(exercise_property, new_workout_exercise)
    end
    new_workout_exercise
  end

  def duplicate_exercise_property(property, new_workout_exercise)
    new_property = property.dup
    new_property.assign_attributes(
      personal_property: prepare_personal_property(property.personal_property),
      workout_exercise: new_workout_exercise
    )
    new_property.save!
  end

  def prepare_personal_property(personal_property)
    ::PersonalProperty.find_by(
      person: @user,
      global_property: personal_property.global_property
    )
  end

end

end
end
