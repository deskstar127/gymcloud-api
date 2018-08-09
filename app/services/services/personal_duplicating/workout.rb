module Services
module PersonalDuplicating

class Workout < BaseService

  def run
    ActiveRecord::Base.transaction { duplicate }
  end

  def input_params
    [:workout]
  end

  def build
    ::PersonalWorkout.new(prepare_attributes)
  end

  private

  def duplicate
    new_workout = ::PersonalWorkout.create!(prepare_attributes)

    @workout.workout_exercises.each do |we|
      duplicate_workout_exercise(we, new_workout)
    end

    new_workout
  end

  def prepare_attributes
    to_include = %w(name description note video_url workout_template_id
                    person_id status workout_template_version is_program_part)
    @workout.attributes.slice(*to_include)
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
      personal_property: property.personal_property,
      workout_exercise: new_workout_exercise
    )
    new_property.save!
  end

end

end
end
