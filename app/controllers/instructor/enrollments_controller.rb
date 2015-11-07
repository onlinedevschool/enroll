class Instructor::Enrollments < Instructor::ApplicationController
  def index
    @applications = Enrollment.pending
  end
end
