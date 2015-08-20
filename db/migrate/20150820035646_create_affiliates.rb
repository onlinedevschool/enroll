class CreateAffiliates < ActiveRecord::Migration
  def change
    create_table :affiliates do |t|
      t.string :name
      t.string :email
      t.string :code

      t.timestamps null: false
    end
  end
end
