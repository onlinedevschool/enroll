class Instructor::EnrollmentsController < Instructor::ApplicationController
  def index
    enrollments
  end

private

  def enrollments
    @enrollments = Enrollment.send((params[:q] || 'pending').to_sym)
  end

end
