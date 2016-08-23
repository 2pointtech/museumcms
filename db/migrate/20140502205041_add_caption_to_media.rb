class AddCaptionToMedia < ActiveRecord::Migration
  def change
    add_column :media, :caption, :text
  end
end
