class EnrollmentsController < ApplicationController
  respond_to :json

  def index
    respond_with(enrollments)
  end

  def show
    respond_with(enrollment)
  end

  def create
    stripe_id = Stripe::Customer.create(email: enrollment_params[:email]).id
    attrs = enrollment_params.merge(stripe_id: stripe_id)
    new_enrollment(attrs).save
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

  def enrollment_params
    attrs = %w[email name weeks pay_option course_id]
    params.require(:enrollment).permit(attrs)
  end
end
