class ConfirmationsController < Devise::ConfirmationsController

  respond_to :json

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: {error: e.record.errors}, status: :unprocessable_entity
  end

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      perform_after_confirmation(resource)
      render json: resource, status: :ok
    else
      render json: {error: resource.errors}, status: :unprocessable_entity
    end
  end

  private

  def perform_after_confirmation(user)
    Services::CRM::ConvertUserToLead.!(user_id: user.id) if user.pro?
    Services::Stripe::UserBootstrap.!(user: user) unless user.pro?
  end

end
