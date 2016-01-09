class AddPromoCodeToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :promo_code, :string
  end
end
