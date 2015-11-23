class Instructors::StudentInterviewInvitationsController < Instructors::ApplicationController
  def create
    enrollment = Enrollment.find(params[:enrollment_id])
    enrollment.invite_to_interview!
    redirect_to instructors_enrollment_applications_path
  end

end
