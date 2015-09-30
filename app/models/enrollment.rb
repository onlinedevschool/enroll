class Enrollment < ActiveRecord::Base
  WEEK_OPTIONS     = [12, 18, 36]
  PRIVATE_SESSIONS = [3, 2, 1]
  FINANCE_FEE      = 980
  PAYMENT_COUNT    = 5
  BASE_PRICE       = 3999

  has_many   :payments, dependent: :destroy

  scope :billable, -> {
    # it is price - 10 because I am not charging cents and so therefore
    # it will otherwise bill one too many times (as the sum of 5 payments
    # will still be less than the price of the produce)
    joins("LEFT JOIN payments ON payments.enrollment_id = enrollments.id").
      group("enrollments.id").
      having("SUM(payments.amount) < (enrollments.price - 10) AND MAX(payments.created_at) < current_date - interval '1' month")
  }

  before_create :record_pricing

  validates :email,       presence: true,
                          uniqueness: { case_sensitive: false, message: "has already been registered"},
                          format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  validates :name,        presence: true

  validates :why,         presence: true

  validates :github_url,  presence: true

  validates :weeks,       presence: true,
                          inclusion: { in: WEEK_OPTIONS,
                                       message: "must be one of #{WEEK_OPTIONS.join(', ')}" }

  validates :financed,    inclusion: { in: [true, false],
                                       message: "must be true or false" }

  def self.financed_price(total_price=nil)
    (total_price || BASE_PRICE) + FINANCE_FEE
  end

  def self.payment_price(total_price=nil)
    financed_price(total_price) / PAYMENT_COUNT
  end

  def self.charge_billable_accounts
    billable.map do |e|
      amount = Enrollment.payment_price(e.price)
      e.payments.create(amount: amount).tap do |p|
        p.charge
      end
    end
  end

  def valid?(*args)
    e = Enrollment.find_by(email: email)
    if e && e.payments.none?
      e.destroy
    end
    super(args)
  end

  def pay_option=(val)
    write_attribute(:financed, val == "payments" )
  end

  def pay_option
    financed? ? "payments" : "prepay"
  end

  def total_price
    financed? ? BASE_PRICE + FINANCE_FEE : BASE_PRICE
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
