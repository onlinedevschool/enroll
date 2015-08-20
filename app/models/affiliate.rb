class Affiliate < ActiveRecord::Base
  AFFILIATE_CODE_KEY = :affiliate_code
  AFFILIATE_PAY_PERCENT = 0.14
  before_create :generate_unique_code

  has_many :affiliate_sales

  def monthly_earnings(datestamp)
    sales = affiliate_sales.where("created_at BETWEEN ? AND ?", datestamp.beginning_of_month, datestamp.end_of_month)
    sales.flat_map(&:enrollment).map(&:price).reduce(:+).to_f * AFFILIATE_PAY_PERCENT
  end


  def year_earnings(datestamp)
    sales = affiliate_sales.where("created_at BETWEEN ? AND ?", datestamp.beginning_of_year, datestamp.end_of_year)
    sales.flat_map(&:enrollment).map(&:price).reduce(:+).to_f * AFFILIATE_PAY_PERCENT
  end
private

  def generate_unique_code
    self.code = loop do
      c = SecureRandom.hex(2)
      break c unless Affiliate.exists?(code: c)
    end
  end
end
