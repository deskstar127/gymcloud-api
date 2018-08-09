module Services
module UserDestroy

class All < Base

  private

  def destroy
    ActiveRecord::Base.transaction do
      destroy_social_activity
      destroy_personal
      destroy_connections
      destroy_templates
      destroy_by_service(PersonalProperties)
      @user.destroy
    end
  end

  def destroy_user_properties
    destroy_by_service(UserProfile)
    destroy_by_service(UserSettings)
    destroy_by_service(UserAuthentications)
    destroy_by_service(AuthTokens)
  end

  def destroy_social_activity
    destroy_by_service(Comments)
    destroy_by_service(Activities)
  end

  def destroy_personal
    destroy_by_service(WorkoutEvents)
    destroy_by_service(PersonalPrograms)
    destroy_by_service(PersonalWorkouts)
  end

  def destroy_connections
    destroy_by_service(UserAgreements)
    destroy_by_service(ClientGroupMemberships)
    destroy_by_service(ClientGroups)
  end

  def destroy_templates
    destroy_by_service(ProgramTemplates)
    destroy_by_service(WorkoutTemplates)
    destroy_by_service(Exercises)
    destroy_by_service(Folders)
  end

  def destroy_by_service(class_name)
    class_name.!(user: @user)
  end

end

end
end
