module Services
module Clients

class Create < BaseService

  def run
    create
  end

  def input_params
    [:current_user, :attrs]
  end

  def build_client
    email = @attrs[:email]
    email ||= generate_fake_email
    email.downcase.squish!
    password = Devise.friendly_token
    @current_user.clients.build(
      email: email,
      password: password,
      password_confirmation: password
    )
  end

  private

  def create
    client = build_client
    client.skip_confirmation!
    client.save!
    client.update_attribute('confirmed_at', nil)
    Services::UserBootstrap::UserProfile.!(user: client)
    Services::UserBootstrap::UserSettings.!(user: client)
    profile_attrs = @attrs.slice('first_name', 'last_name')
    client.user_profile.update_attributes!(profile_attrs)
    create_agreement(client)
    client
  end

  def create_agreement(client)
    @current_user.agreements_as_pro.create!(
      client: client,
      category: AgreementCategory.find_by(symbol: 'trainer'),
      status: :active
    )
  end

  def generate_fake_email
    token = Devise.friendly_token
    "u+#{token}@gymcloud.com"
  end

end

end
end
