ActiveAdmin.register GlobalProperty do

  menu parent: 'Global'

  permit_params :name, :unit, :symbol, :position, :property_unit_id,
    property_unit_ids: []

  index do
    selectable_column
    id_column
    column :symbol
    column :name
    column :default_unit
    column :units do |model|
      model.property_units.pluck(:short_name).join('/')
    end
    column :position
    column :created_at
    actions
  end

  filter :property_units
  filter :symbol
  filter :name
  filter :default_unit
  filter :position
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "#{f.object.class.name.titleize} Details" do
      f.input :symbol
      f.input :name
      f.input :default_unit,
        as: :select,
        collection: f.object.property_units
      f.input :property_units,
        as: :select,
        collection: ::PropertyUnit.all,
        multiple: true
      f.input :position
    end
    f.actions
  end

  controller do

    def create
      super
      Services::GlobalProperties::Add.!(
        global_property: resource
      )
    end

  end

end
