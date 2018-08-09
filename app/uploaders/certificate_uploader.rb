class CertificateUploader < CarrierWave::Uploader::Base

  def self.which_storage
    Rails.env.production? ? :aws : :file
  end

  storage which_storage

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png tiff pdf)
  end

end
