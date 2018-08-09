# encoding: utf-8

class PodcastUploader < CarrierWave::Uploader::Base

  def self.which_storage
    Rails.env.production? ? :aws : :file
  end

  storage which_storage

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def extension_white_list
    %w(m4a mp3)
  end

end
