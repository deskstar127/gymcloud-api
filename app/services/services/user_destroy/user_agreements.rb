module Services
module UserDestroy

class UserAgreements < Base

  private

  def destroy
    destroy_as_client
    destroy_as_pro
  end

  def destroy_as_client
    @user.agreements_as_client.destroy_all
  end

  def destroy_as_pro
    @user.clients.each do |client|
      Services::UserDestroy::All.!(user: client) if client.email_is_fake?
    end
    @user.agreements_as_pro.destroy_all
  end

end

end
end
