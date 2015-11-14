class CreatePrivateSessions < ActiveRecord::Migration
  def change
    create_table :private_sessions do |t|
      t.references :student, index: true, foreign_key: true
      t.text :notes, null: false, default: ''
      t.datetime :started_at, null: false
      t.datetime :ended_at

      t.timestamps null: false
    end
  end
end
