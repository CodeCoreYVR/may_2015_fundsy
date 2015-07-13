class NearbyCampaignsController < ApplicationController
  before_action :authenticate_user!

  def index
    @campaigns = Campaign.near([current_user.latitude, current_user.longitude], 20)
  end
end
