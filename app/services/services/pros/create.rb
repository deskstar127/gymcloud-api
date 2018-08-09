module Services
module Pros

class Create < Services::Clients::Create

  def build_pro
    build_client
  end

  private

  def create
    pro = super

    Services::UserBootstrap::PersonalProperties.!(user: pro)
    Services::UserBootstrap::Folders.!(user: pro)
    Services::UserBootstrap::TestClients.!(user: pro)

    pro
  end

  def create_agreement(pro)
    return if @current_user.pro?
    @current_user.agreements_as_client.create!(
      pro: pro,
      category: AgreementCategory.find_by(symbol: 'trainer'),
      status: :active
    )
  end

end

end
end
