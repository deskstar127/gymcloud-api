ActiveAdmin.register UserAccountType do

  menu parent: 'Presets'

  permit_params :name, :icon

  index do
    selectable_column
    id_column
    column :name
    column :icon
    actions
  end

  filter :name
  filter :icon
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "#{f.object.class.name.titleize} Details" do
      f.input :name
      f.input :icon, required: false
    end
    f.actions
  end

end
