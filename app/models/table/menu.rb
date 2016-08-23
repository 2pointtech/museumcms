class Table::Menu < ActiveRecord::Base
  belongs_to :site
  has_many :media, :dependent => :destroy, :as => :attachable

  attr_accessible :content, :label, :title, :type, :site_id
end
