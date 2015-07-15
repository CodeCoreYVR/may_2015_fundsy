class PublishingsController < ApplicationController
  before_action :authenticate_user!

  def create
    campaign = Campaign.find params[:campaign_id]
    if campaign.publish!
      if current_user.can_publish_to_twitter?
        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = Rails.application.secrets.twitter_api_key
          config.consumer_secret     = Rails.application.secrets.twitter_api_secret
          config.access_token        = current_user.credentials_token
          config.access_token_secret = current_user.credentials_secret
        end
        client.update("I just published a campaign!")
      end
      expire_fragment("recent_campaigns")
      redirect_to campaign, notice: "Campaign Published"
    else
      redirect_to campaign, alert: "Can't publish, may be already published"
    end
  end
end
