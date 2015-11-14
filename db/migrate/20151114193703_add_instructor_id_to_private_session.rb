class AddInstructorIdToPrivateSession < ActiveRecord::Migration
  def change
    add_reference :private_sessions, :instructor, index: true, foreign_key: true
  end
end
