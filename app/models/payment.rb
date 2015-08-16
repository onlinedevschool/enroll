class Payment < ActiveRecord::Base
  belongs_to :enrollment

  def charge(token)
    set_payment_source(token)
    charge = Stripe::Charge.create(
      customer: enrollment.stripe_id,
      currency: 'usd',
      amount: amount * 100
    )
    update_attribute(:auth_code, charge.id)
  end

  def set_payment_source(token)
    customer = Stripe::Customer.retrieve(enrollment.stripe_id)
    customer.source = token
    customer.save
  end
end
