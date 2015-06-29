require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe "validations" do
    def valid_attributes(new_attributes = {})
      {title:       "Some valid title",
       description: "Some valid description",
       goal:        1000000}.merge(new_attributes)
    end

    it "requires a title" do
      # GIVEN: setting up the test => new Campaign object
      campaign = Campaign.new valid_attributes(title: nil)
      # WHEN: Validatin the campaign
      # THEN: It's invalid
      # campaign.should be_invalid # <= Deprecated Syntax
      # be_invalid in an RSpec matcher for Rails
      # be_invalid will call .valid? on the `campaign` object and make sure
      # that it's false
      expect(campaign).to be_invalid
    end

    it "requires a description" do
      campaign = Campaign.new valid_attributes(description: nil)
      expect(campaign).to be_invalid
    end

    it "requires a goal" do
      campaign = Campaign.new valid_attributes(goal: nil)
      campaign.save
      expect(campaign.errors.messages).to have_key(:goal)
    end

    it "requires a goal greater than 10" do
      campaign = Campaign.new valid_attributes(goal: 10)
      expect(campaign).to be_invalid
    end

    it "requires the campaign title to be unique" do
      # GIVEN: campaign already created in the database
      Campaign.create valid_attributes

      # WHEN: trying to create another campain with the same title
      campaign = Campaign.new valid_attributes
      campaign.save

      # THEN: it should have an error on the title key
      expect(campaign.errors.messages).to have_key(:title)
    end

  end
end
