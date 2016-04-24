class AddMultiplierToEnrollment < ActiveRecord::Migration
  def change
    add_column :enrollments, :multiplier, :decimal, null: false, default: 1
  end
end
