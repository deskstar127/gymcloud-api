ActiveAdmin.register ClientGroupMembership do

  menu parent: 'Users'

  permit_params :client_group_id, :client_id

end