module Services
module ProgramPreset

class Import < BaseService

  def run
    import
  end

  def input_params
    %i(user program_preset program_template_ids)
  end

  def defaults
    {program_template_ids: []}
  end

  private

  def import
    ActiveRecord::Base.transaction do
      program_templates = @program_preset
        .program_templates
        .where { id.in(my { @program_template_ids }) }

      new_programs = program_templates.map do |pt|
        duplicate(pt) unless @user.program_templates
            .where(original_id: [pt.original_id, pt.id].compact).any?
      end
      new_programs.compact
    end
  end

  def duplicate(program_template)
    program = Services::TemplateDuplicating::Program.!(
      program: program_template,
      user: @user,
      folder_id: @user.programs_folder.id
    )
    duplicate_program_workouts(program.program_workouts)
    program
  end

  def duplicate_program_workouts(program_workouts)
    program_workouts.each do |pw|
      wt = pw.workout
      next if @user.workout_templates
          .where(is_visible: true)
          .where(original_id: [wt.original_id, wt.id].compact).any?
      duplicate_workout(wt)
    end
  end

  def duplicate_workout(workout_template)
    workout = Services::TemplateDuplicating::Workout.!(
      workout: workout_template,
      user: @user,
      folder_id: @user.workouts_folder.id
    )
    duplicate_workout_exercises(workout.workout_exercises)
    workout
  end

  def duplicate_workout_exercises(workout_exercises)
    workout_exercises.each do |we|
      exercise = we.exercise
      next if @user.exercises
          .where(original_id: [exercise.original_id, exercise.id].compact).any?
      duplicate_exercise(exercise)
    end
  end

  def duplicate_exercise(exercise)
    Services::TemplateDuplicating::Exercise.!(
      exercise: exercise,
      user: @user,
      folder_id: @user.exercises_folder.id
    )
  end

end

end
end
