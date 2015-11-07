class AddLastContactedOnToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :last_contacted_on, :date
  end
end
