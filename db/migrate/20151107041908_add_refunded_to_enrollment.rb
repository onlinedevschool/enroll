class AddRefundedToEnrollment < ActiveRecord::Migration
  def change
    add_column :enrollments, :refunded_at, :datetime
    add_column :enrollments, :refund_reason, :text
    add_column :enrollments, :refund_amount, :integer
  end
end
