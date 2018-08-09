class RegistrationsController < Devise::RegistrationsController

  respond_to :json

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: {error: e.record.errors}, status: 422
  end

  def create
    build_resource(sign_up_params)
    # resource.skip_confirmation!
    resource.save!
    resource.become_a_pro! unless params[:user][:is_client]
    HtmlMailer.delay.welcome_new_user(resource.id)
    Services::UserBootstrap::All.!(user: resource)
    entity = {id: resource.id, user_profile: {id: resource.user_profile.id}}

    render json: entity, status: :created
  end

end
