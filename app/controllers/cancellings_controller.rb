class CancellingsController < ApplicationController
  before_action :authenticate_user!

  def create
    campaign = Campaign.find params[:campaign_id]
    if campaign.cancel!
      redirect_to campaign, notice: "Campaign was cancelled"
    else
      redirect_to campaign, alert: "unable to cancel campaign"
    end
  end
end
