class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps null: false
    end

    add_column :posts, :category_id, :integer, null: false
    add_index :posts, :category_id
  end
end
