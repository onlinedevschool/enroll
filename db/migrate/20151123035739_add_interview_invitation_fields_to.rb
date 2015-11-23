class AddInterviewInvitationFieldsTo < ActiveRecord::Migration
  def change
    add_column :enrollments, :interview_invitation_sent_at, :datetime
  end
end
