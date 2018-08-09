class InvitationsController < Devise::InvitationsController

  protect_from_forgery with: :null_session

  respond_to :json

  def update
    super
    if resource.pro?
      resource.clients.where(is_active: false).update_all(is_active: true)
    end
  end

end
