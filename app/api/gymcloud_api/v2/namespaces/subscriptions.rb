module GymcloudAPI::V2
module Namespaces

class Subscriptions < Base

namespace :subscriptions do

  params do
    requires :id, type: String, desc: 'Stripe Subscription ID'
  end
  route_param :id do

    desc 'Delete Stripe Subscription'
    delete do
      subscription = Services::Stripe::CancelSubscription.!(
        user: current_user,
        id: params[:id]
      )
      present(subscription)
    end

  end

end

end

end
end
