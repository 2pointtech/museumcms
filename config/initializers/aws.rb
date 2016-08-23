AWS_ACCESS_KEY='AKIAJM55USDJJI2DF3MQ'
AWS_SECRET_KEY='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'

if Rails.env.stage?
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => AWS_ACCESS_KEY,
      :aws_secret_access_key  => AWS_SECRET_KEY
    }
    config.fog_directory  = 'di-kstate'                          # required
    config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"} # optional, defaults to {}
  end
else
  CarrierWave.configure do |config|
    config.storage = :file
  end
end
