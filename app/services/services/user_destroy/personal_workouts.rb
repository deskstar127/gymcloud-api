module Services
module UserDestroy

class PersonalWorkouts < Base

  private

  def destroy
    @user.personal_workouts.destroy_all
  end

end

end
end
