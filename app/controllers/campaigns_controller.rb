class CampaignsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update]

  def index
    @campaigns = Campaign.all
  end

  def new
    @campaign = Campaign.new
  end

  def create
    campaign_params = params.require(:campaign).
                        permit(:title, :description, :due_date, :goal)
    @campaign = Campaign.new campaign_params
    @campaign.user = current_user
    if @campaign.save
      redirect_to campaign_path(@campaign), notice: "Campaign created!"
    else
      render :new
    end
  end

  def edit
    @campaign = current_user.campaigns.find params[:id]
  end

  def show
    @campaign = Campaign.find params[:id]
  end

  def update
    render nothing: true
  end
end
