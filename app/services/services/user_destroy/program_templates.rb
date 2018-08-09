module Services
module UserDestroy

class ProgramTemplates < Base

  private

  def destroy
    @user.program_templates.each { |pp| destroy_program_template(pp) }
  end

  def destroy_program_template(program)
    program.program_workouts.each do |pw|
      Services::ProgramWorkout::Destroy.!(program_workout: pw)
    end
    program.program_weeks.destroy_all
    if program_not_assigned?(program)
      program.really_destroy!
    else
      program.destroy
    end
  end

  def program_not_assigned?(program)
    ::PersonalProgram.where(program_template: program).empty?
  end

end

end
end
