class EnrollmentsController < ApplicationController
  skip_before_action :verify_authenticity_token,
                      only: [:create]

  def index
    respond_with(enrollments)
  end

  def show
    respond_with(enrollment)
  end

  def new
    new_enrollment
  end

  def create
    new_enrollment(enrollment_params).save
    respond_with(enrollment)
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

  def enrollment_params
    params.require(:enrollment).permit(:name, :weeks, :course_id,
                                       :financed, :email)
  end
end
