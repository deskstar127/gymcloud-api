module GymcloudAPI::V2
module Namespaces

class Cards < Base

namespace :cards do

  params do
    requires :id, type: String, desc: 'Stripe Card ID'
  end
  route_param :id do

    desc 'Add Card To Stripe Customer'
    patch do
      card = Services::Stripe::AddCard.!(
        user: current_user,
        id: params[:id]
      )
      present(card)
    end

    desc 'Delete Stripe Card'
    delete do
      card = Services::Stripe::DeleteCard.!(
        user: current_user,
        id: params[:id]
      )
      present(card)
    end

  end

end

end

end
end
