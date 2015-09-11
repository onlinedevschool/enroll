class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :author, index: true, foreign_key: true
      t.string :title,      null:false
      t.string :permalink,  index: true
      t.text :html,         null:false
      t.text :markdown,     null:false
      t.datetime :published_at

      t.timestamps null: false
    end
  end
end
