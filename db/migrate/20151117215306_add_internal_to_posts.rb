class AddInternalToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :internal, :boolean, default: false
    Post.find_by(permalink: 'congratulations-you-have-applied-to-the-devschool').
      update(internal: true)
  end
end
