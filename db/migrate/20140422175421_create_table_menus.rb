class CreateTableMenus < ActiveRecord::Migration
  def change
    create_table :table_menus do |t|
      t.string :label
      t.string :title
      t.string :type
      t.text :content
      t.references :site

      t.timestamps
    end
    add_index :table_menus, :site_id
  end
end
