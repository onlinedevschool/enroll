class AddInternalToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :internal, :boolean, default: false
    p = Post.find_by(permalink: 'congratulations-you-have-applied-to-the-devschool')
    p.update(internal: true) if p
  end
end
