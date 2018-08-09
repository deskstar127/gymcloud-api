class PasswordsController < Devise::PasswordsController

  respond_to :json

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: {error: e.record.errors}, status: 422
  end

  # POST /resource/password
  def create
    attrs = resource_params
    self.resource = resource_class.send_reset_password_instructions(attrs)

    if successfully_sent?(resource)
      render json: {}, status: :created
    else
      render json: {error: resource.errors}, status: :unprocessable_entity
    end
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    render(json: {}, status: :ok) && return if resource.errors.empty?

    render json: {error: resource.errors}, status: :unprocessable_entity
  end
end