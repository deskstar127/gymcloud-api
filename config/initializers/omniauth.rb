class OmniAuth::Strategies::OAuth2
  # most strategies (Facebook, GoogleOauth2) do not override this method, it means that
  # for such strategies JSON posting of access_token will work out of the box
  def callback_phase_with_json
    # Doing the same thing as Rails controllers do, giving uniform access to GET, POST and JSON params
    # reqest.params contains only GET and POST params as a hash
    # env[..] contains JSON, XML, YAML params as a hash
    # see ActionDispatch::Http::Parameters#parameters
    parsed_params = env['action_dispatch.request.request_parameters']
    if parsed_params
      %w(code access_token id_token).each do |attr|
        request.params[attr] = parsed_params[attr] if parsed_params[attr]
      end
    end
    callback_phase_without_json
  end
  alias_method_chain :callback_phase, :json
end