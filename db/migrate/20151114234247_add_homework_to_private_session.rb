class AddHomeworkToPrivateSession < ActiveRecord::Migration
  def change
    add_column :private_sessions, :homework, :text
  end
end
