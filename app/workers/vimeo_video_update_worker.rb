class VimeoVideoUpdateWorker

  include Sidekiq::Worker

  sidekiq_options retry: 5

  def perform(video_id)
    video   = Video.find video_id
    service = VimeoVideoUpdateService.new

    return if service.update(video)
    VimeoVideoUpdateWorker.perform_in(2.minutes, video_id)
  end

end
