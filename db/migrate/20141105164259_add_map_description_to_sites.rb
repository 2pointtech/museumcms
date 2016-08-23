class AddMapDescriptionToSites < ActiveRecord::Migration
  def change
    add_column :table_sites, :map_description, :text
  end
end
