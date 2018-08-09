module Services
module UserDestroy

class ClientGroupMemberships < Base

  private

  def destroy
    @user.client_group_memberships.destroy_all
  end

end

end
end
