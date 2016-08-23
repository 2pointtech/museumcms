class AddColorToSites < ActiveRecord::Migration
  def change
    add_column :table_sites, :color, :string
  end
end
