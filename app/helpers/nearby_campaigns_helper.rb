module NearbyCampaignsHelper

  def campaigns_markers(campaigns)
    Gmaps4rails.build_markers(campaigns) do |campaign, marker|
      marker.lat campaign.latitude
      marker.lng campaign.longitude
      campaign_link = link_to(campaign.title, campaign)
      info_window = "#{campaign_link}<br>#{campaign.description.truncate(25)}"
      marker.infowindow info_window
    end
  end
end
