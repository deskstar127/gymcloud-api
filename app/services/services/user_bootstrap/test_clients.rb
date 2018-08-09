module Services
module UserBootstrap

class TestClients < BaseService

  def run
    bootstrap
  end

  def input_params
    [:user]
  end

  private

  def bootstrap
    group = bootstrap_group
    clients = bootstrap_clients
    add_clients(group, clients)
  end

  def bootstrap_group
    ::ClientGroup.create!(name: 'Test Group', pro: @user)
  end

  def bootstrap_clients
    (1..2).each_with_object([]) { |i, memo| memo << bootstrap_client(i) }
  end

  def bootstrap_client(index)
    Services::Clients::Create.!(
      attrs: {
        'first_name' => 'Test',
        'last_name' => "Client#{index}"
      },
      current_user: @user
    )
  end

  def add_clients(group, clients)
    clients.each do |user|
      ClientGroupMembership.create!(
        client_group: group,
        client: user
      )
    end
  end

end

end
end
