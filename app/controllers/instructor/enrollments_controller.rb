class Instructor::EnrollmentsController < Instructor::ApplicationController
  def index
    enrollments
  end

  def destroy
    Enrollment.find(params[:id]).update_attributes(rejected_at: DateTime.now)
    redirect_to instructor_enrollments_path
  end

private

  def enrollments
    @enrollments = Enrollment.send((params[:q] || 'pending').to_sym)
  end

end
