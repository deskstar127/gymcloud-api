# == Schema Information
#
# Table name: user_authentications
#
#  id                         :integer          not null, primary key
#  user_id                    :integer
#  authentication_provider_id :integer
#  uid                        :string
#  params                     :text
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  email                      :string
#

class UserAuthentication < ActiveRecord::Base

  belongs_to :user
  belongs_to :authentication_provider

  serialize :params

  def self.create_from_omniauth(params, user, provider)
    create(
      user_id: user.id,
      authentication_provider_id: provider.id,
      uid: params[:uid],
      email: params[:email],
      params: params.to_json
    )
  end

end
