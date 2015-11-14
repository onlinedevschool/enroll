class Instructors::PrivateSessionsController < Instructors::ApplicationController
  def index
    @private_sessions ||= current_instructor.private_sessions
  end
end
