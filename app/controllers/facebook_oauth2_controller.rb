class FacebookOauth2Controller < ApplicationController

  respond_to :json

  def mobile_facebook_oauth2
    @access_token = params['accessToken']
    @graph = Koala::Facebook::API.new(@access_token)
    token = Services::SocialLogin::Create.!(attrs: process_user)
    render json: {token: token.token}
  end

  private

  def process_user
    raw_user = @graph.get_object('me')
    {
      provider: 'facebook',
      uid: raw_user['id'],
      is_signup: params['is_signup'],
      email: raw_user['email'],
      first_name: raw_user['first_name'],
      last_name: raw_user['last_name']
    }
  end

end