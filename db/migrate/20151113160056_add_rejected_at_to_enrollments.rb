class AddRejectedAtToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :rejected_at, :datetime
  end
end
