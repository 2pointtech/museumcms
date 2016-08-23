class AddTicketFields < ActiveRecord::Migration
  def change
    add_column :ticketing_tickets, :child_price, :float
    add_column :ticketing_tickets, :additional_cost, :boolean
  end
end
