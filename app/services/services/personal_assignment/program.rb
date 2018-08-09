module Services
module PersonalAssignment

class Program < BaseService

  def run
    create_personal
  end

  def input_params
    [:template, :user]
  end

  def build_personal
    PersonalProgram.new(prepare_attributes)
  end

  private

  def create_personal
    program = nil
    ActiveRecord::Base.transaction do
      program = PersonalProgram.create!(prepare_attributes)
      program_workouts = @template.program_workouts.without_week
      weeks = @template.program_weeks

      program_workouts.each { |pw| create_program_workout(pw, program) }
      weeks.each { |week| create_week_with_workouts(week, program) }

      deactivate_old_programs(program.id)
    end

    program
  end

  def assign_workout(program, workout, old_program_workout, week_id)
    to_include = %w(note position)
    attributes = old_program_workout.attributes.slice(*to_include).merge(
      program: program,
      workout: workout,
      week_id: week_id
    )
    ::ProgramWorkout.create!(attributes)
  end

  def prepare_attributes
    to_include = %w(name description note)
    @template.attributes.slice(*to_include).merge(
      program_template: @template,
      person: @user,
      status: :active
    )
  end

  def create_week_with_workouts(week, program)
    new_week = create_week(week, program)
    week.program_workouts.each do |pw|
      create_program_workout(pw, program, new_week.id)
    end
  end

  def create_week(old_week, new_program)
    ::ProgramWeek.create!(
      name: old_week.name,
      position: old_week.position,
      program: new_program
    )
  end

  def create_program_workout(pw, program, week_id = nil)
    personal_workout = create_personal_workout(pw.workout)

    assign_workout(program, personal_workout, pw, week_id)
  end

  def create_personal_workout(workout)
    Services::PersonalAssignment::Workout.!(
      template: workout,
      user: @user,
      is_program_part: true
    )
  end

  def deactivate_old_programs(new_id)
    PersonalProgram
      .where(
        program_template: @template,
        person: @user
      )
      .where
      .not(id: new_id)
      .update_all(status: PersonalProgram.statuses[:inactive])
  end

end

end
end
