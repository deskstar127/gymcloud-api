module GymcloudAPI::V2
module Namespaces

class Pros < Base

namespace :pros do

  desc 'Create Pro'
  params do
    optional :first_name, type: String
    optional :last_name, type: String
    optional :email, type: String
  end
  post do
    pro = ::User.where(email: params[:email]).take

    unless pro
      service = Services::Pros::Create.new(
        attrs: filtered_params,
        current_user: current_user
      )
      pro = service.build_pro
      authorize!(:create, pro)
      service.process
      pro = service.result
      pro.become_a_pro!
    end

    present(pro, with: Entities::User)
  end

  desc 'Send Invite to Pro'
  params do
    optional :email, type: String
  end
  post '/invitation' do
    pro = if params[:email].blank?
            current_user.pros.take
          else
            ::User.where(email: params[:email]).take
          end

    authorize!(:invite, pro)
    Services::Pros::Invite.!(
      current_user: current_user,
      user: pro,
      email: pro.email
    )
    present(pro, with: Entities::User)
  end

  desc 'Provide Pro'
  post '/request' do
    request = ::RequestPro.find_or_initialize_by(
      client: current_user,
      pro_provided: false
    )
    authorize!(:create, request)
    request.save!
    ::HtmlMailer.delay.provide_pro(current_user.id)
    present(request)
  end

end

end

end
end
