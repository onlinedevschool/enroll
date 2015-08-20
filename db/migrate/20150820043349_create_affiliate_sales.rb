class CreateAffiliateSales < ActiveRecord::Migration
  def change
    create_table :affiliate_sales do |t|
      t.references :enrollment, index: true, foreign_key: true
      t.references :affiliate, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
