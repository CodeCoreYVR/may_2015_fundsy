json.array! @campaigns do |campaign|
  json.id          campaign.id
  json.title       campaign.title
  json.description campaign.description
  json.goal        campaign.goal
  json.due_date    campaign.due_date
  json.url         campaign_url(campaign)
end
