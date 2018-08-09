module Services
module UserDestroy

class Activities < Base

  private

  def destroy
    ::Activity.where { (recipient == my { @user }) | (owner == my { @user }) }
    ::ReadMark.where(
      readable_type: ::Activity.base_class.name,
      user: @user
    ).destroy_all
  end

end

end
end
