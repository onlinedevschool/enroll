class Enrollment < ActiveRecord::Base
  WEEK_OPTIONS     = [12, 18, 36]
  PRIVATE_SESSIONS = [3, 2, 1]
  FINANCE_FEE      = 1000
  PAYMENT_COUNT    = 5
  BASE_PRICE       = 3499
  PAYMENT_PRICE    = (BASE_PRICE + FINANCE_FEE) / PAYMENT_COUNT

  belongs_to :course
  has_many   :payments

  before_create :record_pricing

  validates :email,       presence: true,
                          uniqueness: true,
                          format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  validates :name,        presence: true

  validates :weeks,       presence: true,
                          inclusion: { in: WEEK_OPTIONS,
                                       message: "must be one of #{WEEK_OPTIONS.join(', ')}" }

  validates :course_id,   presence: true,
                          numericality: true

  validates :financed,    inclusion: { in: [true, false],
                                       message: "must be true or false" }

  def pay_option=(val)
    write_attribute(:financed, val == "payments" )
  end

  def pay_option
    financed? ? "payments" : "prepay"
  end

  def total_price
    financed? ? course.price + FINANCE_FEE : course.price
  end

  def first_payment_amount
    financed? ? total_price / PAYMENT_COUNT : total_price
  end

  def initial_payment_made?
    payments.select(&:persisted?).any?
  end

  def record_pricing
    write_attribute(:price, total_price)
  end
end
