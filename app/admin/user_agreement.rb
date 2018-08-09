ActiveAdmin.register UserAgreement do

  menu parent: 'Users'

  permit_params :pro_id, :client_id, :category_id, :status

  form do |f|
    f.inputs "#{f.object.class.name.titleize} Details" do
      f.input :pro
      f.input :client
      f.input :category
      f.input :status, as: :select, collection: UserAgreement.statuses.keys
    end
    f.actions
  end

end
