module Services
module CRM

class ConvertUserToLead < BaseService

  def run
    return false unless adapter.active?
    @user = ::User.find(@user_id)
    create_new_lead
  end

  def input_params
    [:user_id]
  end

  private

  def create_new_lead
    attrs = adapter.created_user_attributes(@user)
    adapter.create_lead(attrs)
  end

  def adapter
    @adapter ||= Adapter.new
  end

end

end
end
