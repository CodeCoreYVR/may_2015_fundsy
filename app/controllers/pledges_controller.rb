class PledgesController < ApplicationController
  before_action :authenticate_user!

  def create
    @campaign = Campaign.find params[:campaign_id]
    pledge_params = params.require(:pledge).permit(:amount)
    @pledge = Pledge.new pledge_params
    @pledge.campaign = @campaign
    if @pledge.save
      redirect_to @campaign
    else
      render "/campaigns/show"
    end
  end
end
