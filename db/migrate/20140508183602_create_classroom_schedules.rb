class CreateClassroomSchedules < ActiveRecord::Migration
  def change
    create_table :classroom_schedules do |t|
      t.string :title
      t.text :feed_url

      t.timestamps
    end
  end
end
