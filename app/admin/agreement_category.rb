ActiveAdmin.register AgreementCategory do

  menu parent: 'Users'

  permit_params :title, :pro_title, :client_title

end