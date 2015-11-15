class Instructors::PrivateSessionsController < Instructors::ApplicationController
  def index
    @private_sessions ||= current_instructor.private_sessions
  end

  def show
    private_session
  end

  def new
    new_private_session
  end

  def create
    if new_private_session(private_session_params).save
      redirect_to instructors_private_sessions_path
    else
      render :new
    end
  end

  def edit
    @private_session ||= current_instructor.private_sessions.find(params[:id])
  end

  def update
    if private_session.update_attributes(private_session_params)
      redirect_to instructors_private_sessions_path
    else
      render :edit
    end
  end

private

  def new_private_session(attrs={})
    @private_session ||= current_instructor.private_sessions.build(attrs)
  end

  def private_session
    @private_session ||= current_instructor.private_sessions.find(params[:id])
  end

  def private_session_params
    params.require(:private_session).
      permit(:started_at, :ended_at, :notes,
             :homework, :student_id)
  end
end
