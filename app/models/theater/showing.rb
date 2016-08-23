class Theater::Showing < ActiveRecord::Base
  include RankedModel
  ranks :row

  attr_accessible :category, :title, :when, :length, :video, :existing_video_id, :auto_play, :row_position
  mount_uploader :video, FileUploader

  belongs_to :existing_video, :class_name => 'Video'

  def as_json(options = {})
    super options.merge :methods => [:existing_video]
  end
end
