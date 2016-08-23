class Ticketing::Event < ActiveRecord::Base
  attr_accessible :content, :date, :file, :title, :type

  mount_uploader :file, ThumbnailUploader

  def self.model_name
    ActiveModel::Name.new(Ticketing::Event)
  end

  def as_json(options = {})
    super options.merge :methods => [ :type ]
  end
end
