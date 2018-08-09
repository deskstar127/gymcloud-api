module Services
module ProgramWorkout

class Create < BaseService

  def run
    create_program_workout
  end

  def input_params
    [:attrs]
  end

  def build_program_workout
    ::ProgramWorkout.new(prepare_attributes)
  end

  private

  def create_program_workout
    ::ProgramWorkout.create!(prepare_attributes)
  end

  def prepare_attributes
    program_class = "::#{@attrs['program_type']}".constantize
    program = program_class.find(@attrs['program_id'])
    workout = prepare_workout(program)
    workout.attributes.slice(*%w(note))
      .merge(
        program: program,
        workout: workout,
        position: @attrs['position'],
        week_id: @attrs['week_id']
      )
  end

  def prepare_workout(program)
    if @attrs['program_type'] == 'ProgramTemplate'
      create_workout_template
    else
      create_personal_workout(program)
    end
  end

  def create_workout_template
    workout_template = ::WorkoutTemplate.find(@attrs['workout_template_id'])
    Services::TemplateDuplicating::Workout.!(
      workout: workout_template,
      user: workout_template.user,
      is_visible: false
    )
  end

  def create_personal_workout(program)
    workout_template = ::WorkoutTemplate.find(@attrs['workout_template_id'])
    Services::PersonalAssignment::Workout.!(
      template: workout_template,
      user: program.person,
      is_program_part: true
    )
  end

end

end
end
