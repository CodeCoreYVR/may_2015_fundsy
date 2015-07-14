class CampaignsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :find_campaign, only: [:edit, :update, :destroy]

  def index
    @recent_campaigns = Campaign.published.limit(3).order("created_at DESC")
    @campaigns = Campaign.published
    respond_to do |format|
      format.html { render }
      format.json { render json: @campaigns.to_json }
    end
  end

  def new
    @campaign = Campaign.new
    2.times { @campaign.reward_levels.build }
  end

  def create
    @campaign = Campaign.new campaign_params
    @campaign.user = current_user
    if @campaign.save
      redirect_to campaign_path(@campaign), notice: "Campaign created!"
    else
      # this will generate an associated number of reward levels that is the
      # difference between the default number and the accepted count
      # @campaign.reward_levels.length: the number of reward levels accepted
      reward_level_count = 2 - @campaign.reward_levels.length
      reward_level_count.times { @campaign.reward_levels.build }
      render :new
    end
  end

  def edit
  end

  def show
    @campaign = Campaign.includes(:comments, :reward_levels).
                         references(:comments, :reward_levels).
                         find(params[:id]).decorate
    @comment  = Comment.new
    @pledge   = Pledge.new
    respond_to do |format|
      format.html { render }
      format.json { render json: {campaign: @campaign,
                                  comments: @campaign.comments,
                                  reward_levels: @campaign.reward_levels}.to_json }
    end
  end

  def update
    if @campaign.update campaign_params
      # redirect_to @campaign
      redirect_to campaign_path(@campaign), notice: "updated!"
    else
      flash[:alert] = "update unsuccessful"
      render :edit
    end
  end

  def destroy
    @campaign.destroy
    redirect_to campaigns_path, notice: "Campaign deleted"
  end

  private

  def find_campaign
    @campaign = current_user.campaigns.find params[:id]
  end

  def campaign_params
    params.require(:campaign).permit(:title, :description,
    :due_date, :goal, {reward_levels_attributes: [:title, :description,
                                                  :amount, :id, :_destroy]})
  end

end
