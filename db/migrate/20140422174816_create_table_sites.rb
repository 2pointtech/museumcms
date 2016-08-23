class CreateTableSites < ActiveRecord::Migration
  def change
    create_table :table_sites do |t|
      t.string :image
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
