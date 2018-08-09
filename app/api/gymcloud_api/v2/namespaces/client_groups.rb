module GymcloudAPI::V2
module Namespaces

class ClientGroups < Base

namespace :client_groups do

  desc 'Create Client Group'
  params do
    requires :name, type: String
  end
  post do
    attributes = filtered_params_with(pro: current_user)
    client_group = ::ClientGroup.new(attributes)
    authorize!(:create, client_group)
    client_group.save!
    present(client_group, with: Entities::ClientGroup)
  end

  params do
    requires :id, type: Integer, desc: 'ClientGroup ID'
  end
  route_param :id do

    desc 'Read Client Group'
    get do
      client_group = ::ClientGroup.find(params[:id])
      authorize!(:read, client_group)
      present(client_group, with: Entities::ClientGroup, nested: true)
    end

    desc 'Update Client Group'
    params do
      optional :name, type: String
    end
    patch do
      client_group = ::ClientGroup.find(params[:id])
      client_group.assign_attributes(filtered_params)
      authorize!(:update, client_group)
      client_group.save!
      present(client_group, with: Entities::ClientGroup)
    end

    desc 'Delete Client Group'
    delete do
      client_group = ::ClientGroup.find(params[:id])
      authorize!(:destroy, client_group)
      client_group.destroy
      present(client_group, with: Entities::ClientGroup)
    end

    mount Namespaces::ClientGroupAssignments

    namespace :members do

      desc 'Fetch Members'
      get do
        client_group = ::ClientGroup.find(params[:id])
        authorize!(:read, client_group)
        members = client_group.clients
        present(members, with: Entities::User)
      end

      params do
        requires :user_id, type: Integer, desc: 'User ID'
      end
      route_param :user_id do

        desc 'Add Member'
        params do
          optional :assign_templates, type: Boolean, default: 'true'
        end
        post do
          service = Services::Clients::AddToGroup.new(
            client_id: params[:user_id],
            group_id: params[:id],
            assign_templates: params[:assign_templates]
          )
          authorize!(:create, service.build)
          client_group = service.run
          present(client_group, with: Entities::ClientGroup)
        end

        desc 'Remove Member'
        delete do
          client_group = ::ClientGroup.find(params[:id])
          user = ::User.find(params[:user_id])
          membership = client_group.client_group_memberships
            .find_by!(client_id: user.id)
          authorize!(:destroy, membership)
          membership.destroy
          user.personal_workouts.each do |pw|
            if pw.workout_template.client_group_id == params[:id]
              pw.status = :inactive
              pw.save!
            end
          end
          present(client_group, with: Entities::ClientGroup)
        end

      end

    end

  end

end

end

end
end
