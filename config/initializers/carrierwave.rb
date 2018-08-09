CarrierWave.configure do |config|

  config.aws_bucket = ENV['AWS_S3_BUCKET']
  config.aws_acl    = 'public-read'
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

  config.aws_attributes = {
    cache_control: 'max-age=315576000',
    expires: 10.years.from_now.httpdate
  }

  config.aws_credentials = {
    access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  }

end
