ActiveAdmin.register ProgramTemplate do

  menu parent: 'Pro'

  permit_params :name, :description, :note, :is_public, :author_id, :folder_id

end
