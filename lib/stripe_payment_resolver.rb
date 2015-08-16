require 'stripe'

module StripePaymentResolver
  extend self

  def charge(enrollment, payment)
    customer = Stripe::Customer.create(
      source: payment.token,
      email:  enrollment.email
    )

    Stripe::Charge.create(
      customer: customer.id,
      currency: 'usd',
      amount: payment.amount.to_i * 100
    )

  end
end
