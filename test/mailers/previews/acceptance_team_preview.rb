# Preview all emails at http://localhost:3000/rails/mailers/acceptance_team
class AcceptanceTeamPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/acceptance_team/notify
  def notify
    AcceptanceTeam.notify
  end

end
