class Payment < ActiveRecord::Base
  belongs_to :enrollment

  def charge(token)
    set_payment_source
    charge = Stripe::Charge.create(
      customer: enrollment.stripe_id,
      currency: 'usd',
      amount: amount * 100
    )
    update_attribute(:auth_code, charge.id)
  end

  def set_payment_source
    customer = Stripe::Customer.create(email: enrollment.email)
    enrollment.update_attribute(:stripe_id, customer.id)
    customer.source = token
    customer.save
  end
end
