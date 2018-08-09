ActiveAdmin.register ClientGroup do

  menu parent: 'Users'

  permit_params :name, :pro_id

end