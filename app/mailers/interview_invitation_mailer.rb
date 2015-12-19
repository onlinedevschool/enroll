class InterviewInvitationMailer < ApplicationMailer

  def notify(enrollment)
    @enrollment = enrollment
    mail(
      to: enrollment.email,
      subject: "🎉 🎂 Congrats, you have been invited to an interview at the Devschool to see if you have what it takes to join our school!"
    )
    @enrollment = enrollment
  end
end
