class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.string :name
      t.string :email
      t.integer :weeks
      t.decimal :price
      t.references :course, index: true, foreign_key: true
      t.boolean :financed

      t.timestamps null: false
    end
  end
end
