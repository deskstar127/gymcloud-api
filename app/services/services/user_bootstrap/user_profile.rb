module Services
module UserBootstrap

class UserProfile < BaseService

  def run
    bootstrap
  end

  def input_params
    [:user, :profile_attrs]
  end

  def defaults
    {profile_attrs: {}}
  end

  private

  def bootstrap
    @user.user_profile.nil? ? create : update
  end

  def create
    @user.create_user_profile!(@profile_attrs)
  end

  def update
    @user.user_profile.update_attributes!(@profile_attrs)
  end

end

end
end
