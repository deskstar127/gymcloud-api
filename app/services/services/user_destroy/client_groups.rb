module Services
module UserDestroy

class ClientGroups < Base

  private

  def destroy
    @user.client_groups.destroy_all
  end

end

end
end
