json.title       @campaign.title
json.description @campaign.description
json.goal        @campaign.goal
json.due_date    @campaign.due_date
json.created_at  @campaign.created_at.strftime("%Y-%b-%d")
json.reward_levels @campaign.reward_levels do |rl|
  json.title       rl.title
  json.description rl.description
  json.amount      rl.amount
end
json.comments @campaign.comments do |comment|
  json.body comment.body
end
