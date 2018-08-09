class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_filter :protect_from_forgery

  def facebook
    social
  end

  def google_oauth2
    social
  end

  def failure
    render json: {errors: [failure_message]}, status: :unprocessable_entity
  end

  private

  def social
    if params['is_linking']
      auth = Services::SocialLogin::Link.!(
        linking_user: linking_user,
        social_user: process_user
      )
      render json: {auth: auth}
    else
      access_token = Services::SocialLogin::Create.!(attrs: process_user)
      render json: {access_token: access_token.token}
    end
  end

  def linking_user
    token = request.headers[:authorization]
      .match(/^Bearer (?<token>.*)$/)[:token]
    User.find_by_access_token(token)
  end

  def split_full_name
    @raw_user.info.tap do |info|
      info.first_name, info.last_name = info.name.split(/\s+/)
    end
  end

  def process_user
    @raw_user = request.env['omniauth.auth']
    split_full_name if @raw_user.info.try(:name)
    {
      provider: @raw_user.provider,
      uid: @raw_user.uid,
      is_signup: params['is_signup'],
      email: @raw_user.info.email,
      first_name: @raw_user.info.first_name,
      last_name: @raw_user.info.last_name
    }
  end
end