class VimeoVideoDeleteService

  def initialize
    @client = Vimeo::Client.new(access_token: ENV['VIMEO_TOKEN'])
  end

  def delete(vimeo_id)
    @client.video(vimeo_id).delete
  end

end
