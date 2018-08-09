class VimeoVideoDeleteWorker

  include Sidekiq::Worker

  sidekiq_options retry: 7

  def perform(vimeo_id)
    VimeoVideoDeleteService.new.delete vimeo_id
  end

end
