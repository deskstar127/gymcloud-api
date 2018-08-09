ActiveAdmin.register PropertyUnit do

  menu parent: 'Global'

  permit_params :name, :short_name

  index do
    selectable_column
    id_column
    column :short_name
    column :name
    column :created_at
    actions
  end

end
