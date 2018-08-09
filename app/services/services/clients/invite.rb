module Services
module Clients

class Invite < BaseService

  def run
    invite
  end

  def input_params
    [:current_user, :user, :email]
  end

  private

  def invite
    email = @email.presence || !@user.email_is_fake? && @user.email
    update_email(email) if email && @user.email != email
    @user.invite!(@current_user) if email
  end

  def update_email(email)
    @user.email = email
    if @user.valid?
      @user.restore_attributes
      @user.update_column('email', email)
    else
      @user.save! # will raise proper exception
    end
  end

end

end
end
