class WackBlogStuffs < ActiveRecord::Migration
  def change
    drop_table :posts, cascade: true
    drop_table :authors, cascade: true
    drop_table :categories, cascade: true
    drop_table :series, cascade: true
  end
end
