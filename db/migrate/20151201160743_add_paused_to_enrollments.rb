class AddPausedToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :paused, :boolean, default: false, null: false
  end
end
