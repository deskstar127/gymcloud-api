module GymcloudAPI::V2
module Namespaces

class Folders < Base

namespace :folders do

  desc 'Create Folder'
  params do
    requires :name, type: String
    requires :parent_id, type: Integer
  end
  post do
    parent_folder = ::Folder.find(params[:parent_id])
    attributes = filtered_params_with(user: current_user)
    folder = parent_folder.children.build(attributes)
    authorize!(:create, folder)
    folder.save!
    present folder, with: Entities::Folder
  end

  params do
    requires :id, type: Integer, desc: 'Folder ID'
  end
  route_param :id do

    desc 'Read Folder'
    get do
      folder = ::Folder.find(params[:id])
      authorize!(:read, folder)
      present(folder, with: Entities::Folder)
    end

    params do
      requires :name, type: String
    end
    desc 'Update Folder'
    patch do
      folder = ::Folder.find(params[:id])
      folder.assign_attributes(filtered_params)
      authorize!(:update, folder)
      folder.save!
      present(folder, with: Entities::Folder)
    end

    desc 'Delete Folder'
    delete do
      folder = ::Folder.find(params[:id])
      authorize!(:destroy, folder)
      folder.destroy_with_items
      present(folder, with: Entities::Folder)
    end

  end

end

end

end
end
