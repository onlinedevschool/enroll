class AddGoalsToStudent < ActiveRecord::Migration
  def change
    add_column :students, :goals, :text
  end
end
