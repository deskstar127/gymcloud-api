module Services
module CRM

class UpdateUserContact < BaseService

  def run
    return false unless adapter.active?
    @user = ::User.find(@user_id)
    return false unless @user
    update_user_contact
  end

  def input_params
    [:user_id]
  end

  private

  def update_user_contact
    contact = adapter.find_contact(@user)
    if contact
      updated_contact = adapter.updated_contact_attributes(@user, contact)
      adapter.update_contact(updated_contact)
    else
      new_contact = adapter.created_contact_attributes(@user)
      adapter.create_contact(new_contact)
    end
  end

  def adapter
    @adapter ||= Adapter.new
  end

end

end
end
