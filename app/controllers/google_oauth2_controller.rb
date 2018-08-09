require 'google/api_client/client_secrets'
require 'google/apis/plus_v1'

class GoogleOauth2Controller < ApplicationController

  respond_to :json

  def mobile_google_oauth2
    # We are getting 'accessToken' from iOS and 'oauthToken' from Android
    if params['accessToken']
      auth_client.access_token = params['accessToken']
    elsif params['oauthToken']
      auth_client.access_token = params['oauthToken']
    else
      fail ArgumentError, 'Token is absent'
    end
    token = Services::SocialLogin::Create.!(attrs: process_user)
    render json: {token: token.token}
  end

  private

  def process_user
    raw_user = fetch_person(params['userId'])
    {
      provider: 'google_oauth2',
      uid: raw_user.id,
      is_signup: params['is_signup'],
      email: raw_user.emails.first.value,
      first_name: raw_user.name.given_name,
      last_name: raw_user.name.family_name
    }
  end

  def auth_client
    return @auth_client if @auth_client
    client_secrets = fetch_client_secrets
    auth_client = client_secrets.to_authorization
    auth_client.scope = [
      'https://www.googleapis.com/auth/plus.login',
      'https://www.googleapis.com/auth/plus.profile.emails.read',
      'https://www.googleapis.com/auth/drive.metadata.readonly'
    ].join(' ')
    auth_client.redirect_uri = ENV['GOOGLE_REDIRECT_URIS']
    @auth_client = auth_client
  end

  def fetch_person(uid)
    plus = Google::Apis::PlusV1::PlusService.new
    plus.get_person(uid, options: {authorization: auth_client})
  end

  def fetch_client_secrets
    Google::APIClient::ClientSecrets.new(
      'web' => {
        'auth_provider_x509_cert_url' => 'https://www.googleapis.com/oauth2/v1/certs',
        'auth_uri' => 'https://accounts.google.com/o/oauth2/auth',
        'client_id' => ENV['GOOGLE_CLIENT_ID'],
        'client_secret' => ENV['GOOGLE_CLIENT_SECRET'],
        'javascript_origins' => [
          ENV['GOOGLE_JAVASCRIPT_ORIGINS']
        ],
        'redirect_uris' => [
          ENV['GOOGLE_REDIRECT_URIS']
        ],
        'token_uri' => 'https://accounts.google.com/o/oauth2/token'
      }
    )
  end

end