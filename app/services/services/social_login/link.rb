module Services
module SocialLogin

class Link < BaseService

  def run
    to_json
  end

  def input_params
    [:linking_user, :social_user]
  end

  private

  def to_json
    auth = return_auth
    {
      id: auth.id,
      email: auth.email,
      provider: provider.name
    }
  end

  def provider
    @provider ||= ::AuthenticationProvider.where(
      name: @social_user[:provider]
    ).first
  end

  def existing_auth
    @existing_auth ||= ::UserAuthentication.where(
      uid: @social_user[:uid],
      authentication_provider_id: provider.id
    ).first
  end

  def create_auth
    ::UserAuthentication.create_from_omniauth(
      @social_user, @linking_user, provider
    )
  end

  def return_auth
    return create_auth unless existing_auth
    if existing_auth.user_id != @linking_user.id
      existing_auth.destroy!
      create_auth
    else
      existing_auth
    end
  end

end

end
end
