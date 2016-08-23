class AddVideoToTheaterShowings < ActiveRecord::Migration
  def change
    add_column :theater_showings, :video, :string
  end
end
