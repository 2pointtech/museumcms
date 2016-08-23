class AddPlaylistField < ActiveRecord::Migration
  def up
    add_column :theater_showings, :auto_play, :boolean
    add_column :theater_showings, :row, :integer, :default => 0 

    index = 0
    for s in Theater::Showing.find(:all)
      s.update_attribute :row_position, index += 1
    end
  end

  def down
    remove_column :theater_showings, :auto_play
    remove_column :theater_showings, :row
  end
end
