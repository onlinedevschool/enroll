class AcceptanceTeamMailer < ApplicationMailer

  def notify(enrollment)
    @enrollment = enrollment
    mail(
      to: "acceptance-team@devschool.rocks",
      subject: "A new application has been submitted!",
    )
  end
end
