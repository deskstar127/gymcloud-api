# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include CarrierWave::BombShelter

  def self.which_storage
    Rails.env.production? ? :aws : :file
  end

  storage which_storage

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :ensure_auto_orient
  process resize_to_fit: [800, 800]
  process convert: 'png'

  version :large do
    process resize_to_fill: [400, 400]
  end

  version :thumb, from_version: :large do
    process resize_to_fill: [100, 100]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def image_type_whitelist
    %i(jpg jpeg gif png)
  end

  def ensure_auto_orient
    manipulate! do |image|
      image.auto_orient
      image = yield(image) if block_given?
      image
    end
  end

end
