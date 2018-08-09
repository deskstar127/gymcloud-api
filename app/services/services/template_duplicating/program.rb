module Services
module TemplateDuplicating

class Program < BaseService

  def run
    duplicate
  end

  def input_params
    [:program, :user, :folder_id]
  end

  def defaults
    {folder_id: nil}
  end

  def build
    ::ProgramTemplate.new(prepare_attributes)
  end

  private

  def duplicate
    @new_program = ::ProgramTemplate.create!(prepare_attributes)

    @program.program_weeks.each do |pw|
      duplicate_program_week(pw)
    end
    @program.program_workouts.where(week_id: nil).each do |pw|
      duplicate_program_workout(pw, nil)
    end

    @new_program
  end

  def prepare_attributes
    to_include = %w(name description note video_url)
    @program.attributes.slice(*to_include).merge(
      is_public: false,
      folder_id: prepare_folder,
      author: @program.author,
      user: @user,
      original: @program.original || @program
    )
  end

  def prepare_folder
    @folder_id ||=
      ::Folder.find_by(name: 'Program Templates', user: @user).id
  end

  def duplicate_program_week(program_week)
    new_program_week = program_week.dup
    new_program_week.assign_attributes(program: @new_program)
    new_program_week.save!
    program_week.program_workouts.each do |program_workout|
      duplicate_program_workout(program_workout, new_program_week)
    end
    new_program_week
  end

  def duplicate_program_workout(program_workout, new_program_week)
    new_program_workout = program_workout.dup
    new_program_workout.assign_attributes(
      week: new_program_week,
      program: @new_program,
      workout: duplicate_workout(program_workout.workout)
    )
    new_program_workout.save!
  end

  def duplicate_workout(workout)
    Services::TemplateDuplicating::Workout.!(
      workout: workout,
      user: @user,
      is_visible: false
    )
  end

end

end
end
