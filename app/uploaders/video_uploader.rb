# encoding: utf-8

class VideoUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  def cache_dir
    "#{Rails.root}/tmp/cache_dir_uploads"
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    model_class = model.class.to_s.underscore
    "#{Rails.root}/tmp/uploads/#{model_class}/#{mounted_as}/#{model.id}"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(avi mp4 mpeg wmv mkv mov m4v 3gp)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details
  # def filename
  #   "something.jpg" if original_filename
  # end

end
