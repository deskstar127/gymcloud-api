module GymcloudAPI::V2
module Namespaces

class UserAuthentications < Base

namespace :user_authentications do

  params do
    requires :id, type: Integer, desc: 'User Authentication ID'
  end
  route_param :id do

    desc 'Delete User Authentication'
    delete do
      authentication = ::UserAuthentication.find(params[:id])
      authorize!(:destroy, authentication)
      authentication.destroy
      present(authentication, with: Entities::UserAuthentication)
    end

  end

end

end

end
end
