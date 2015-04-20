if Rails.env.development? or Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    # config.enable_processing = false
    config.ignore_integrity_errors = false
    config.ignore_processing_errors = false
    config.ignore_download_errors = false
  end
else #Production, staging, etc.

  CarrierWave.configure do |config|
    config.storage    = :aws
    config.aws_bucket = ENV.fetch('AWS_S3_BUCKET_NAME')
    # config.aws_acl    = :public_read
    # config.asset_host = 'http://example.com'
    config.aws_attributes = {'x-amz-server-side​-encryption' => "AES256"}
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

    config.aws_credentials = {
      access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),
      secret_access_key: ENV.fetch('AWS_SECRET_KEY')
    }
  end
end
