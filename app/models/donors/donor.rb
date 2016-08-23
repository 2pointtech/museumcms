class Donors::Donor < ActiveRecord::Base
  include RankedModel
  ranks :row
  attr_accessible :description, :name, :photo, :row, :row_position
  mount_uploader :photo, ImageUploader

end
