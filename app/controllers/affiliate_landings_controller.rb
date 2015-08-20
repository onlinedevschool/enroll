class AffiliateLandingsController < ApplicationController
  def create
    cookies.permanent.signed[Affiliate::AFFILIATE_CODE_KEY] = params[:affiliate_id]
    render nothing: true
  end
end
