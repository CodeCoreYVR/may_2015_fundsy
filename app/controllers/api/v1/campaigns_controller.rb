class Api::V1::CampaignsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @campaigns = Campaign.published
  end

  def show
    @campaign = Campaign.find params[:id]
  end

  def create
    campaign = Campaign.new params.require(:campaign).permit(:title, :description, :goal)
    if campaign.save
      render json: {success: true}
    else
      render json: {success: false, errors: campaign.errors.full_messages}
    end
  end
end
