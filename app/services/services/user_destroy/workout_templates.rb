module Services
module UserDestroy

class WorkoutTemplates < Base

  private

  def destroy
    @user.workout_templates.each { |wt| destroy_workout_template(wt) }
  end

  def destroy_workout_template(workout_template)
    if workout_not_assigned?(workout_template)
      workout_template.really_destroy!
    else
      workout_template.destroy
    end
  end

  def workout_not_assigned?(workout_template)
    ::PersonalWorkout.where(workout_template: workout_template).empty?
  end

end

end
end
