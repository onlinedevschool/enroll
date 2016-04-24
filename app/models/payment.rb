class Payment < ActiveRecord::Base
  belongs_to :enrollment

  scope :oldest, -> {
    order(created_at: :asc)
  }

  def charge(token=nil)
    set_payment_source if token
    charge = Stripe::Charge.create(
      customer: enrollment.stripe_id,
      currency: 'mxn',
      amount: ((amount * 100).to_f * enrollment.multiplier).to_i,
      description: "DevSchool (devschool.rocks)"
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
