module Services
module UserBootstrap

class UserSettings < BaseService

  def run
    bootstrap
  end

  def input_params
    [:user, :settings_attrs]
  end

  def defaults
    {settings_attrs: {units_system: :imperial, is_tutorial_finished: false}}
  end

  private

  def bootstrap
    @user.user_settings.nil? ? create : update
  end

  def create
    @user.create_user_settings!(@settings_attrs)
  end

  def update
    @user.user_settings.update_attributes!(@settings_attrs)
  end

end

end
end
