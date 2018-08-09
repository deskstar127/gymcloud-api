module Services
module UserDestroy

class AuthTokens < Base

  private

  def destroy
    q = "DELETE FROM oauth_access_tokens WHERE resource_owner_id = #{@user.id}"
    ActiveRecord::Base.connection.execute(q)
  end

end

end
end
