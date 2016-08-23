class CreateTicketingTickets < ActiveRecord::Migration
  def change
    create_table :ticketing_tickets do |t|
      t.string :title
      t.float :price
      t.text :content
      t.string :type

      t.timestamps
    end
  end
end
