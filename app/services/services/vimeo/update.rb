module Services
module Vimeo

class Update < BaseService

  def run
    update
  end

  def input_params
    [:vimeo_id, :attrs]
  end

  private

  def update
    vimeo_video.edit(attributes)
  end

  def vimeo_video
    client = ::Vimeo::Client.new(access_token: ENV['VIMEO_TOKEN'])
    client.video(@vimeo_id)
  end

  def attributes
    default_settings = Rails.application.config_for(:vimeo_video_params)
    default_settings.merge(@attrs)
  end

end

end
end
