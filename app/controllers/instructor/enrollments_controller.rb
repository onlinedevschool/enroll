class Instructor::EnrollmentsController < Instructor::ApplicationController
  def index
    @enrollments = Enrollment.pending
  end
end
