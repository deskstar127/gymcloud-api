class UpdateWeeksCount < ActiveRecord::Migration

  def up
    [ProgramTemplate, PersonalProgram].each do |klass|
      klass.where(weeks_count: nil).each do |program|
        count = program.program_weeks.count
        program.update_attribute(:weeks_count, count)
      end
    end
  end

  def down
  end

end
