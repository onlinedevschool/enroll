class AddPaymentCountToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :payment_count, :integer, null: false, default: 6
  end
end
