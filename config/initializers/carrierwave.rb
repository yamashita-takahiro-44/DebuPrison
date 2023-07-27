CarrierWave.configure do |config|
  # if Rails.env.production?
    config.storage    = :aws
    config.aws_bucket = ENV.fetch('AWS_S3_BUCKET')
    config.aws_acl    = 'public-read'
 
    # The maximum period for authenticated_urls is only 7 days.
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
 
    # Set custom options such agit s cache control to leverage browser caching
    config.aws_attributes = {
      expires: 1.week.from_now.httpdate,
      cache_control: 'max-age=604800'
    }
 
    # aws credential
    config.aws_credentials = {
      # 今回はIAM ロールを使用するため記載しない
      access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),
      secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
      region: ENV.fetch('AWS_REGION')
    }
  # else
    # テスト時はローカルにファイルを保存する
    # config.storage = :file
  # end
end
 
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
