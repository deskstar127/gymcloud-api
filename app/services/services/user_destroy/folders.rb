module Services
module UserDestroy

class Folders < Base

  private

  def destroy
    ::Folder.where(user: @user).order(id: :desc).destroy_all
  end

end

end
end
