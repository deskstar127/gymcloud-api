ActiveAdmin.register Exercise do

  menu parent: 'Pro'

  permit_params :name, :description, :video_url, :is_public,
    :author_id, :folder_id

end
