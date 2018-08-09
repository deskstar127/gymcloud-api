module GymcloudAPI::V2
module Namespaces

class Notifications < Base

namespace :notifications do

  route_param :id do

    desc 'Mark Notification as Read'
    params do
      requires :status, type: Boolean, default: 'true', desc: 'Read status'
    end
    patch :read do
      notification = ::Activity.find(params[:id])
      authorize!(:update, notification)

      method = params[:status] ? :mark_as_read! : :mark_as_unread!
      notification.send(method, for: current_user)

      present notification, with: Entities::Notification
    end

  end

end

end

end
end
