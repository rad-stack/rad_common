class S3CorsSettingsUpdater
  def update!
    s3_client.put_bucket_cors(
      bucket: bucket,
      cors_configuration: {
        cors_rules: [
          {
            allowed_methods: %w[GET POST PUT DELETE],
            allowed_origins: [allowed_origin],
            allowed_headers: ['*'],
            expose_headers: []
          }
        ]
      }
    )

    puts "CORS settings updated for #{bucket} : #{check_cors}"
  end

  private

  def s3_client
    @s3_client ||= Aws::S3::Client.new(
      region: RadConfig.secret_config_item!(:s3_region),
      access_key_id: RadConfig.secret_config_item!(:s3_access_key_id),
      secret_access_key: RadConfig.secret_config_item!(:s3_secret_access_key)
    )
  end

  def check_cors
    s3_client.get_bucket_cors(bucket: bucket)
  end

  def allowed_origin
    @allowed_origin ||= "https://#{RadConfig.host_name!}"
  end

  def bucket
    @bucket ||= RadConfig.secret_config_item!(:s3_bucket)
  end
end
