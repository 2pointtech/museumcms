class AddVideoIdToShowings < ActiveRecord::Migration
  def up
    add_column :theater_showings, :existing_video_id, :integer
  end

  def down
    remove_column :theater_showings, :existing_video_id
  end
end
