class PledgesController < ApplicationController
  before_action :authenticate_user!

  def create
    @campaign = Campaign.find(params[:campaign_id]).decorate
    pledge_params = params.require(:pledge).permit(:amount)
    service = Pledges::CreatePledge.new( campaign: @campaign,
                                         params:   pledge_params,
                                         user:     current_user)
    if service.call
      redirect_to @campaign
    else
      @pledge = service.pledge
      render "/campaigns/show"
    end
    # @campaign = Campaign.find params[:campaign_id]
    # pledge_params = params.require(:pledge).permit(:amount)
    # @pledge = Pledge.new pledge_params
    # @pledge.campaign = @campaign
    # if @pledge.save
    #   redirect_to @campaign
    # else
    #   render "/campaigns/show"
    # end
  end
end
