ActiveAdmin.register ::PodcastEpisode do

  menu priority: 1

  permit_params :title, :description, :published_at, :file, :file_size,
    :content_type, :author, :duration

end
