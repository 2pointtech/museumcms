class Table::Site < ActiveRecord::Base
  attr_accessible :image, :x, :y, :color, :map_description
  mount_uploader :image, ImageUploader

  has_many :menus, :dependent => :destroy

  def as_json(options = {})
    super options.merge :include => { :menus => { :methods => [ :type ], :include => { :media => { :methods => [:image, :video] } } } }
  end
end
