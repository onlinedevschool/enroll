class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :enrollment_id, null: false
      t.text :notes

      t.timestamps null: false
    end
  end
end
