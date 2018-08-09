module GymcloudAPI::V2
module Namespaces

# rubocop:disable Metrics/ClassLength
class Videos < Base

namespace :videos do

  helpers GlobalHelpers
  helpers do
    def scope_service(scope)
      {
        vimeo: Services::VideosSearch::Vimeo,
        youtube: Services::VideosSearch::Youtube,
        all: Services::VideosSearch::All
      }[scope.to_sym] || Services::VideosSearch::Gymcloud
    end

    def scope_entity_class(scope)
      {
        vimeo: Entities::VimeoVideo,
        youtube: Entities::YoutubeVideo
      }[scope.to_sym] || Entities::Video
    end
  end

  desc 'Search video'
  params do
    requires :q, type: String, desc: 'Query for search'
    optional :scope, type: String, default: 'mine',
      values: %w(all mine gymcloud vimeo youtube),
      desc: 'Search scope'
    optional :order, type: String,
      values: %w(recent oldest),
      default: 'recent',
      desc: 'Search order'
    use :pagination
  end
  get '/search' do
    service = scope_service(params[:scope])
    videos = service.!(filtered_params_with(user: current_user))
    if params[:scope] == 'all'
      videos.reduce([]) do |results, (key, val)|
        results.concat(scope_entity_class(key).represent(val))
      end
    else
      entity_class = scope_entity_class(params[:scope])
      present(videos, with: entity_class)
    end
  end

  desc 'Retrieve videos'
  params do
    optional :q, type: String, desc: 'Query for search'
    optional :order, type: String,
      values: %w(recent oldest),
      default: 'recent',
      desc: 'Search order'
  end
  paginate per_page: 50, max_per_page: 50
  get do
    videos = Video.owned_by(current_user.id).send(params[:order]).all
    videos = videos.search_by_criteria(params[:q]) if params[:q].present?
    paginated_videos = paginate(videos)

    present(
      [{
        per_page: params[:per_page],
        page: params[:page],
        total_entries: videos.count,
        total_pages: paginated_videos.total_pages
      }, Entities::Video.represent(paginated_videos)]
    )
  end

  desc 'Create new video and uploading it to Vimeo'
  params do
    requires :file, type: Rack::Multipart::UploadedFile, desc: 'Video file'
    requires :name, type: String, desc: 'Video name'
  end
  post do
    attributes = filtered_params_with(author: current_user)
    attributes[:tmp_file] = attributes.delete(:file)
    video = Video.new(attributes)
    # NOTE: this is not async b/c of heroku limits
    VimeoUploaderService.new.upload(video)
    VimeoVideoUpdateWorker.perform_in(2.minutes, video.id)

    present video, with: Entities::Video
  end

  params do
    requires :id, type: Integer, desc: 'Video ID'
  end
  route_param :id do

    desc 'Retrieve a video'
    get do
      video = Video.find(params[:id])
      present(video, with: Entities::Video)
    end

    desc 'Update a video'
    params do
      requires :name, type: String, desc: 'Video name'
    end
    patch do
      video = Video.find(params[:id])
      video.name = params[:name]
      video.save!

      client = ::Vimeo::Client.new(access_token: ENV['VIMEO_TOKEN'])
      vimeo_video = client.video(video.vimeo_id)
      vimeo_video.edit(name: video.name)

      present(video, with: Entities::Video)
    end

    desc 'Delete a video'
    delete do
      video = Video.find(params[:id])
      Services::Video::Delete.!(video: video)

      present(video, with: Entities::Video)
    end

  end

end

end

end
end
