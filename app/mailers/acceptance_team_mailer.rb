class AcceptanceTeamMailer < ApplicationMailer

  def notify(enrollment)
    @enrollment = enrollment
    mail(
      to: "applications@devschool.rocks",
      subject: "A new application has been submitted!",
    )
  end
end
