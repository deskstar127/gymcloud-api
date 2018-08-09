module GymcloudAPI::V2
module Namespaces

class ClientsPerformance < Base

namespace :clients_performance do

  desc 'Fetch Clients performance'
  get do
    clients = current_user.clients
    present(clients, with: Entities::ClientPerformance)
  end

end

end

end
end
