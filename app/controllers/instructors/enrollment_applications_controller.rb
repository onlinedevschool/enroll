class Instructors::EnrollmentApplicationsController < Instructors::ApplicationController
  def index
    enrollment_applications
  end

  def destroy
    Enrollment.find(params[:id]).update_attributes(rejected_at: DateTime.now)
    redirect_to instructors_enrollment_appliations_path
  end

private

  def enrollment_applications
    @enrollment_applications ||= Enrollment.send((params[:q] || 'pending').to_sym)
  end

end
