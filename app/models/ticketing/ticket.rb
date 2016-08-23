class Ticketing::Ticket < ActiveRecord::Base
  attr_accessible :content, :price, :title, :type, :child_price, :additional_cost
  def self.model_name
    ActiveModel::Name.new(Ticketing::Ticket)
  end

  def as_json(options = {})
    super options.merge :methods => [ :type ]
  end
end
