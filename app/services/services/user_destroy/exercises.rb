module Services
module UserDestroy

class Exercises < Base

  private

  def destroy
    @user.exercises.each { |wt| destroy_exercise(wt) }
  end

  def destroy_exercise(exercise)
    if exercise_not_assigned?(exercise)
      exercise.really_destroy!
    else
      exercise.destroy
    end
  end

  def exercise_not_assigned?(exercise)
    ::WorkoutExercise.where(exercise: exercise).empty?
  end

end

end
end
