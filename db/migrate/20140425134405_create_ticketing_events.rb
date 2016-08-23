class CreateTicketingEvents < ActiveRecord::Migration
  def change
    create_table :ticketing_events do |t|
      t.string :title
      t.string :file
      t.date :date
      t.text :content
      t.string :type

      t.timestamps
    end
  end
end
