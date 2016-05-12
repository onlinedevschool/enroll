class AddLayawayToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :layaway, :boolean, default: false
  end
end
