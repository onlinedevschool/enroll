class AcceptanceTeamMailer < ApplicationMailer

  def notify(enrollment)
    @enrollment = enrollment
    mail(
      to: "jim@devschool.rocks",
      subject: "A new application has been submitted!",
    )
  end
end
