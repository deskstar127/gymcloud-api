module GymcloudAPI::V2
module Entities

class VimeoVideo < Grape::Entity

  expose :id do |obj|
    obj.uri.match(/(\d+)/).captures.first.to_i
  end
  expose :created_at
  expose :updated_at
  expose :name
  expose :description
  expose :duration
  expose :embed_url do |obj|
    str = obj.embed.html
    unless str.nil?
      url = URI.extract(str).first
      url.sub("?#{URI(url).query}", '')
    end
  end
  expose :link, as: :full_url
  expose :author_name do |obj|
    obj.user[:name]
  end
  expose :preview_picture_url do |obj|
    obj.preview_picture_url
  end
  expose :type do |_obj|
    'vimeo'
  end
  expose :created_time, as: :uploaded_at

end

end
end
