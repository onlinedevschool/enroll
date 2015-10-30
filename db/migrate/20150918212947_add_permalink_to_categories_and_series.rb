class AddPermalinkToCategoriesAndSeries < ActiveRecord::Migration
  def change
    add_column :series, :permalink, :string, null: false, default: ""
    add_column :categories, :permalink, :string, null: false, default: ""

    root_category = Category.create(name: "Announcements")
  end
end
