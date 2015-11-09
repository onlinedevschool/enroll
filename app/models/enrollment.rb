class Enrollment < ActiveRecord::Base
  WEEK_OPTIONS     = [12, 18, 36]
  PRIVATE_SESSIONS = [3, 2, 1]
  FINANCE_FEE      = 980
  PAYMENT_COUNT    = 5
  BASE_PRICE       = 3999

  has_many   :payments, dependent: :destroy


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

  scope :billable, -> {
    # it is price - 10 because I am not charging cents and so therefore
    # it will otherwise bill one too many times (as the sum of 5 payments
    # will still be less than the price of the produce)
    joins("LEFT JOIN payments ON payments.enrollment_id = enrollments.id").
      group("enrollments.id").
      having("SUM(payments.amount) < (enrollments.price - 10) AND MAX(payments.created_at) < current_date - interval '1' month")
  }

  scope :active, -> {
    where("stripe_id IS NOT NULL AND refunded_at IS NULL")
  }

  scope :pending, -> {
    where("stripe_id IS NULL AND refunded_at IS NULL")
  }

  before_create :record_pricing

  def self.charge_billable_accounts
    billable.map do |e|
      e.payments.create(amount: next_payment_amount).tap do |p|
        p.charge
      end
    end
  end

  def self.payment_price
    financed_price / 5
  end

  def self.financed_price
    BASE_PRICE + FINANCE_FEE
  end

  def active?
    stripe_id.present? && !refunded? && weeks_left > 0
  end

  def weeks_left
    remaining = weeks - (DateTime.now.to_i - payments.first.created_at.to_i)/60/60/24/7
    remaining < 0 ? 0 : remaining
  end

  def refunded?
    refunded_at.present?
  end

  def pay_option=(val)
    write_attribute(:financed, val == "payments" )
  end

  def pay_option
    financed? ? "payments" : "prepay"
  end

  def price
    read_attribute(:price) || BASE_PRICE
  end

  def adjusted_price
    financed? ? self.financed_price : price
  end

  def next_payment_amount
    financed? ? price / PAYMENT_COUNT : price
  end

  def initial_payment_made?
    payments.select(&:persisted?).any?
  end

  def record_pricing
    write_attribute(:price, adjusted_price)
  end

end
