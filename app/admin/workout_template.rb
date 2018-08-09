ActiveAdmin.register WorkoutTemplate do

  menu parent: 'Pro'

  permit_params :name, :description, :note,
    :video_url, :is_public,
    :author_id, :folder_id

end
