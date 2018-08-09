module Services
module ProgramWorkout

class CreateNew < BaseService

  def run
    create_program_workout
  end

  def input_params
    [:attrs, :user]
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

    {
      program: program,
      workout: prepare_workout(program),
      position: @attrs['position'],
      week_id: @attrs['week_id']
    }
  end

  def prepare_workout(program)
    if @attrs['program_type'] == 'ProgramTemplate'
      workout_template
    else
      personal_workout(program)
    end
  end

  def workout_template
    folder_id = @user.folders.root.children
      .where(name: 'Workout Templates').pluck(:id).first

    ::WorkoutTemplate.create!(
      name: workout_template_name,
      folder_id: folder_id,
      is_visible: false,
      is_public: false,
      author: @user,
      user: @user
    )
  end

  def workout_template_name
    index = ::ProgramWorkout.where(
      program_id: @attrs['program_id'],
      week_id: @attrs['week_id']
    ).count
    "Workout #{index + 1}"
  end

  def personal_workout(program)
    Services::PersonalAssignment::Workout.!(
      template: workout_template,
      user: program.person,
      is_program_part: true
    )
  end

end

end
end
