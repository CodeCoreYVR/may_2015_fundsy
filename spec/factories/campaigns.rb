FactoryGirl.define do
  factory :campaign do
    # This enables us to create a campaign and associate it with a user
    # by calling: create(:campaign, user: user)
    # if we don't pass it a user option then it will automatically
    # create a user object and associate it with the campaign
    association :user, factory: :user
    sequence(:title)  {|n| "#{Faker::Company.catch_phrase}-#{n}"}
    description       Faker::Lorem.paragraph
    goal              10000
  end

end
