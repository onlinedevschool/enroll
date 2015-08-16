class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :enrollment, index: true, foreign_key: true
      t.string  :token
      t.string  :auth_code
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
