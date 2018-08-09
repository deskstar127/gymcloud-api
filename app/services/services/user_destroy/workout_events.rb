module Services
module UserDestroy

class WorkoutEvents < Base

  private

  def destroy
    @user.workout_events.each(&:destroy)
  end

end

end
end
