module Services
module UserDestroy

class PersonalPrograms < Base

  private

  def destroy
    @user.personal_programs.each { |pp| destroy_personal_program(pp) }
  end

  def destroy_personal_program(program)
    program.program_workouts.each do |pw|
      Services::ProgramWorkout::Destroy.!(program_workout: pw)
    end

    program.program_weeks.destroy_all
    program.destroy
  end

end

end
end
