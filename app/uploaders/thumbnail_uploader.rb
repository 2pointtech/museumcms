# encoding: utf-8

class ThumbnailUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :resize_to_fill => [1200, 1200]
end
