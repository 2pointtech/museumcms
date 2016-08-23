class Video < ActiveRecord::Base
  attr_accessible :file, :name

  mount_uploader :file, FileUploader

  def name
    self["name"].blank? ? self["file"] : self["name"]
  end
end
