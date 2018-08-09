module Services
module PersonalAssignment

class Workout < BaseService

  def run
    create_personal
  end

  def input_params
    [:template, :user, :is_program_part, :is_default_for_group]
  end

  def defaults
    {is_program_part: false, is_default_for_group: false}
  end

  def build_personal
    PersonalWorkout.new(prepare_attributes)
  end

  private

  def create_personal
    workout = PersonalWorkout.create!(prepare_attributes)
    @template.workout_exercises.each do |item|
      workout_exercise = assign_exercise(workout, item)

      item.exercise_properties.each do |exercise_property|
        assign_property_to_exercise(workout_exercise, exercise_property)
      end
    end

    deactivate_old_workouts(workout.id) unless @is_program_part

    workout
  end

  def prepare_attributes
    to_include = %w(name description note video_url)
    @template.attributes.slice(*to_include).merge(
      workout_template: @template,
      person: @user,
      status: :active,
      is_program_part: @is_program_part,
      workout_template_version: @template.try(:version).try(:index)
    )
  end

  def assign_exercise(workout, workout_exercise)
    exercise = workout_exercise.source_exercise
    WorkoutExercise.create!(
      workout: workout,
      exercise: exercise,
      exercise_version: exercise.version&.index,
      note: workout_exercise.note,
      position: workout_exercise.position,
      order_name: workout_exercise.order_name,
      source: workout_exercise
    )
  end

  def assign_property_to_exercise(workout_exercise, exercise_property)
    ExerciseProperty.create!(
      personal_property: exercise_property.personal_property,
      workout_exercise: workout_exercise,
      value: exercise_property.value,
      value2: exercise_property.value2,
      position: exercise_property.position,
      property_unit: exercise_property.property_unit,
      source: exercise_property
    )
  end

  def deactivate_old_workouts(new_id)
    PersonalWorkout
      .where(
        workout_template: @template,
        person: @user
      )
      .where.not(id: new_id)
      .update_all(status: PersonalWorkout.statuses[:inactive])
  end

end

end
end
