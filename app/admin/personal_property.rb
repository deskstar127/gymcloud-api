ActiveAdmin.register PersonalProperty do

  menu parent: 'Personal'

  permit_params :global_property_id, :position, :is_visible, :person_id

end
