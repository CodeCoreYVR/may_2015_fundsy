class CampaignsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def new
    @campaign = Campaign.new
  end

  def create
    campaign_params = params.require(:campaign).
                        permit(:title, :description, :due_date, :goal)
    @campaign = Campaign.new campaign_params
    @campaign.save
    redirect_to campaign_path(@campaign), notice: "Campaign created!"
  end
end
