class UpdateVimeoVideoAttributes < ActiveRecord::Migration
  def up
    ::Video.all.each do |video|
      VimeoUpdateAttributesWorker.perform_async(video.vimeo_id, {})
    end
  end
end
