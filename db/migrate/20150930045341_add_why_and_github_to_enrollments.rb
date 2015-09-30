class AddWhyAndGithubToEnrollments < ActiveRecord::Migration
  def change
    add_column :enrollments, :why, :text
    add_column :enrollments, :github_url, :string
    add_column :enrollments, :accepted_at, :datetime
  end
end
