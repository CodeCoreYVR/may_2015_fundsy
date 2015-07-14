class PledgesMailer < ApplicationMailer

  def notify_campaign_owner(pledge)
    @campaign = pledge.campaign
    @user     = @campaign.user
    mail(to: @user.email, subject: "Someone pledged $#{pledge.amount} to your campaign")
  end
end
