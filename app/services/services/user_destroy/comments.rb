module Services
module UserDestroy

class Comments < Base

  private

  def destroy
    ::Comment.where(user: @user).destroy_all
    ::ReadMark.where(readable_type: 'Comment', user: @user).destroy_all
  end

end

end
end
