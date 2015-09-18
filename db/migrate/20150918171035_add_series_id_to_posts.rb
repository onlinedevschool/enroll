class AddSeriesIdToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :series, index: true, foreign_key: true
  end
end
