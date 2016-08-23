class CreateTheaterShowings < ActiveRecord::Migration
  def change
    create_table :theater_showings do |t|
      t.string :title
      t.string :category
      t.datetime :when
      t.integer :length

      t.timestamps
    end
  end
end
