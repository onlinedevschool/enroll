class AffiliateSale < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :affiliate

  def self.track(cookies, enrollment)
    return if cookies[Affiliate::AFFILIATE_CODE_KEY].blank?
    code = cookies.signed[Affiliate::AFFILIATE_CODE_KEY]
    return unless affiliate = Affiliate.find_by(code: code)
    create(affiliate: affiliate, enrollment: enrollment)
  end
end
