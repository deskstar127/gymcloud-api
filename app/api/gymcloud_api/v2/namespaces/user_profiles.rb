module GymcloudAPI::V2
module Namespaces

class UserProfiles < Base

namespace :user_profiles do

  params do
    requires :id, type: Integer, desc: 'User Profile ID'
  end
  route_param :id do

    desc 'Fetch User Profile' do
      success Entities::UserProfile
    end
    get do
      profile = ::UserProfile.find(params[:id])
      authorize!(:read, profile)
      present(profile, with: Entities::UserProfile)
    end

    desc 'Update User Profile' do
      success Entities::UserProfile
    end
    params do
      optional :gender, type: String, values: ::UserProfile.genders.keys
      optional :height, type: Float
      optional :weight, type: Float
      optional :bodyfat, type: Float
      optional :first_name, type: String
      optional :last_name, type: String
      optional :location, type: String
      optional :zip, type: String
      optional :employer, type: String
      optional :birthday, type: Date
      optional :timezone, type: String
    end
    patch do
      profile = ::UserProfile.find(params[:id])
      profile.assign_attributes(filtered_params)
      authorize!(:update, profile)
      profile.save!
      Services::CRM::UpdateUserContact.!(user_id: profile.user.id)
      present(profile, with: Entities::UserProfile)
    end

    desc 'Update User Avatar' do
      success Entities::UserProfile
    end
    params do
      requires :avatar, type: Rack::Multipart::UploadedFile
    end
    patch :avatar do
      profile = ::UserProfile.find(params[:id])
      authorize!(:update, profile)
      profile.avatar = ActionDispatch::Http::UploadedFile.new(params[:avatar])
      profile.save!
      present(profile, with: Entities::UserProfile)
    end

  end

end

end

end
end
