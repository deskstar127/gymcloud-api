module Services
module UserDestroy

class UserProfile < Base

  private

  def destroy
    @user.user_profile.destroy
  end

end

end
end
