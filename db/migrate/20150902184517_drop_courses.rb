class DropCourses < ActiveRecord::Migration
  def up
    remove_column :enrollments, :course_id
    drop_table :courses
  end

  def down
    create_table :courses do |t|
      t.string :name
      t.integer :price

      t.timestamps null: false
    end
  end
end
