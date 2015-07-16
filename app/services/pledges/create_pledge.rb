class Pledges::CreatePledge
  include Virtus.model

  attribute :campaign, Campaign
  attribute :params, Hash
  attribute :user, User

  attribute :pledge, Pledge
  # It's recommended that your service classes have a single
  # public instance method that performs that action of this
  # class
  def call
    @pledge          = Pledge.new params
    @pledge.user     = user
    @pledge.campaign = campaign
    if @pledge.save
      PledgesMailer.notify_campaign_owner(@pledge).deliver_now
      true
    else
      false
    end
  end

end
