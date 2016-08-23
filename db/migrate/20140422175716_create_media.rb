class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :file
      t.string :title
      t.integer :attachable_id
      t.string :attachable_type

      t.timestamps
    end
  end
end
