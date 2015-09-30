class EnrollmentsController < ApplicationController
  respond_to :json

  def index
    respond_with(enrollments)
  end

  def show
    respond_with(enrollment)
  end

  def create
    new_enrollment(enrollment_params).save
    notify_acceptance_team(new_enrollment)
    respond_with(new_enrollment)
  end

private

  def enrollment
    @enrollment ||= Enrollment.find(params[:id])
  end

  def enrollments
    @enrollments ||= Enrollment.all
  end

  def new_enrollment(attrs={})
    @enrollment ||= Enrollment.new(attrs)
  end

  def notify_acceptance_team(enrollment)
    AcceptanceTeamMailer.notify(enrollment).deliver_now
  end

  def enrollment_params
    attrs = %w[email name weeks pay_option why github_url]
    params.require(:enrollment).permit(attrs)
  end
end
