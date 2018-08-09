module GymcloudAPI::V2
module Namespaces

class PersonalProperties < Base

namespace :personal_properties do

  params do
    requires :id, type: Integer, desc: 'Personal Property ID'
  end
  route_param :id do

    desc 'Read Personal Property'
    get do
      property = ::PersonalProperty.find(params[:id])
      authorize!(:read, property)
      present(property, with: Entities::PersonalProperty)
    end

    desc 'Update Personal Property'
    params do
      optional :position, type: Integer
      optional :is_visible, type: Boolean
    end
    patch do
      property = ::PersonalProperty.find(params[:id])
      property.assign_attributes(filtered_params)
      authorize!(:update, property)
      property.save!
      present(property, with: Entities::PersonalProperty)
    end

  end

end

end

end
end
