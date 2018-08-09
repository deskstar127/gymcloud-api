module Services
module CRM
module Adapters

class Insightly

  def active?
    Insightly2.api_key.present?
  end

  def create_lead(attrs)
    client.create_lead(lead: attrs)
  rescue ::Insightly2::Errors::ClientError => e
    Rails.logger.error "Insightly Error: #{e.response}"
  end

  def create_contact(attrs)
    client.create_contact(contact: attrs)
  rescue ::Insightly2::Errors::ClientError => e
    Rails.logger.error "Insightly Error: #{e.response}"
  end

  def update_contact(attrs)
    client.update_contact(contact: attrs)
  rescue ::Insightly2::Errors::ClientError => e
    Rails.logger.error "Insightly Error: #{e.response}"
  end

  def created_user_attributes(user)
    {
      first_name: user.user_profile.first_name,
      last_name: user.user_profile.last_name,
      email_address: user.email,
      lead_description: "gymcloud_user_id: #{user.id}",
      tags: [
        {TAG_NAME: 'Registered'},
        {TAG_NAME: 'Professional'}
      ]
    }
  end

  def created_contact_attributes(user) # rubocop:disable Metrics/MethodLength
    {
      first_name: user.user_profile.first_name,
      last_name: user.user_profile.last_name,
      contactinfos: [
        TYPE: 'email',
        LABEL: 'Work',
        DETAIL: user.email
      ],
      tags: [
        {TAG_NAME: 'Registered'},
        {TAG_NAME: 'Professional'}
      ],
      background: detailed_background(user)
    }
  end

  def updated_user_attributes(user)
    {
      first_name: user.user_profile.first_name,
      last_name: user.user_profile.last_name,
      contactinfos: [
        TYPE: 'email',
        LABEL: 'Work',
        DETAIL: user.email
      ],
      background: detailed_background(user)
    }
  end

  def updated_contact_attributes(user, attrs)
    user_attrs = updated_user_attributes(user)
    attrs.merge(user_attrs)
  end

  def find_contact(user)
    re = /gymcloud_user_id: #{user.id}/
    client
      .get_contacts
      .find { |contact| contact.dig('BACKGROUND') =~ re }
  end

  private

  def client
    ::Insightly2.client
  end

  def detailed_background(user) # rubocop:disable Metrics/MethodLength
    <<-EOT.sub(/\n$/, '')
      gymcloud_user_id: #{user.id}
      first_name: #{user.user_profile.first_name}
      last_name: #{user.user_profile.last_name}
      gender: #{user.user_profile.gender}
      birthday: #{user.user_profile.birthday}
      height: #{user.user_profile.height}
      weight: #{user.user_profile.weight}
      bodyfat: #{user.user_profile.bodyfat}
      zip: #{user.user_profile.zip}
      location: #{user.user_profile.location}
      occupation: #{user.user_profile.employer}
    EOT
  end

end

end
end
end
