class Api::V1::CampaignsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @campaigns = Campaign.published
  end

  def show
    @campaign = Campaign.find params[:id]
  end

  def create
    render json: {success: true}
  end
end
