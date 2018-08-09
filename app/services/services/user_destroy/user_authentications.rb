module Services
module UserDestroy

class UserAuthentications < Base

  private

  def destroy
    @user.authentications.destroy_all
  end

end

end
end
