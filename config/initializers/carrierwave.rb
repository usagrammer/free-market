require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    region: 'ap-northeast-1'
  }

  config.fog_directory  = 'free-market'
  config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/free-market'
end
