class Medium < ActiveRecord::Base
  attr_accessible :attachable_id, :attachable_type, :file, :title, :caption
  mount_uploader :file, FileUploader
  belongs_to :attachable, :polymorphic => true

  def video?
    self.file.file.extension =~ /(mp4|webm|m4v)/i
  end

  def image?
    !video?
  end

  def as_json(options = {})
    super options.merge :methods => [:image, :video]
  end
end
