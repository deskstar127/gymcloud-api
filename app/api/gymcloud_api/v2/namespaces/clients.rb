module GymcloudAPI::V2
module Namespaces

class Clients < Base

namespace :clients do

  desc 'Create Client'
  params do
    requires :first_name, type: String
    requires :last_name, type: String
    optional :email, type: String
  end
  post do
    service = Services::Clients::Create.new(
      attrs: filtered_params,
      current_user: current_user
    )
    client = service.build_client
    authorize!(:create, client)
    service.process
    client = service.result
    present(client, with: Entities::User)
  end

  params do
    requires :id, type: Integer, desc: 'Client ID'
  end
  route_param :id do
    desc 'Delete Client' do
      success Entities::UserAgreement
    end
    delete do
      user_agreement = ::UserAgreement.find_by!(
        client_id: params[:id],
        pro: current_user
      )
      user_agreement.status = :finished
      user_agreement.save!
      ::ClientGroupMembership.destroy_all(client_id: params[:id])
      present(user_agreement, with: Entities::UserAgreement)
    end
  end

end

end

end
end
