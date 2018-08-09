class VimeoUpdateAttributesWorker

  include Sidekiq::Worker

  sidekiq_options retry: 5

  def perform(vimeo_id, attributes)
    Services::Vimeo::Update.!(
      vimeo_id: vimeo_id,
      attrs: attributes
    )
  end

end
