require 'rails_helper'

RSpec.describe Api::V1::CampaignsController, type: :controller do
  # By default RSpec for controllers doesn't automatically render the views
  # this line forces RSpec to render the views for our specs
  render_views

  let(:user) { create(:user) }

  describe "listing all campaigns" do
    let!(:campaign) { create(:campaign, {aasm_state: :published}) }

    context "with valid api key" do
      def valid_request
        get :index, api_key: user.api_key, format: :json
      end

      it "returns the campaign's title" do
        valid_request
        expect(response.body).to include campaign.title
      end

      it "returns the campaign's description" do
        valid_request
        expect(response.body).to match /#{campaign.description}/i
      end

      it "returns the campaign's goal" do
        valid_request
        parsed_response = JSON.parse(response.body)
        expect(parsed_response[0]["goal"]).to eq(campaign.goal)
      end
    end

    context "with invalid api key" do

      it "returns a 401 HTTP code status" do
        get :index, format: :json
        expect(response.status).to eq(401)
      end

    end

  end
end
