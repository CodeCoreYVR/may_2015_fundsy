FactoryGirl.define do
  factory :campaign do
    sequence(:title)  {|n| "#{Faker::Company.catch_phrase}-#{n}"}
    description       Faker::Lorem.paragraph
    goal              10000
  end

end
