# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :resize_to_fill => [600,600]
  end

  process :resize_to_limit => [1920, 1080], :if => :is_image?

  def is_image? file
    file.extension =~ /(jpg|jpeg|png)/i
  end
end
