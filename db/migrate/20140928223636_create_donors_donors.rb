class CreateDonorsDonors < ActiveRecord::Migration
  def change
    create_table :donors_donors do |t|
      t.string :name
      t.text :description
      t.integer :row
      t.string :photo

      t.timestamps
    end
  end
end
