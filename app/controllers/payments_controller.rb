require 'stripe_payment_resolver'

class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %w[index show create]
  respond_to :html, only: %w[new]
  respond_to :json, except: %w[new]

  def index
    respond_with(payments)
  end

  def show
    respond_with(payment)
  end

  def new
    @total  = enrollment.total_price
    @amount = enrollment.first_payment_amount

    new_payment
  end

  def create
    attrs = payment_params.merge(amount: enrollment.first_payment_amount)
    new_payment(attrs).save
    charge(new_payment)
    respond_with(enrollment, new_payment)
  end

private

  def enrollment
    @enrollment ||= Enrollment.find(params[:enrollment_id])
  end

  def payment
    @payment ||= enrollment.payments.find(params[:id])
  end

  def payments
    @payments ||= enrollment.payments
  end

  def new_payment(attrs={})
    @payment ||= enrollment.payments.build(attrs)
  end

  def charge(payment)
    charge = StripePaymentResolver.charge(enrollment, payment)
    payment.update_attributes(auth_code: charge.id)
  end

  def payment_params
    attrs = %w[token]
    params.require(:payment).permit(attrs)
  end
end
