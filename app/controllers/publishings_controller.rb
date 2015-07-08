class PublishingsController < ApplicationController
  before_action :authenticate_user!

  def create
    campaign = Campaign.find params[:campaign_id]
    if campaign.publish!
      redirect_to campaign, notice: "Campaign Published"
    else
      redirect_to campaign, alert: "Can't publish, may be already published"
    end
  end
end
