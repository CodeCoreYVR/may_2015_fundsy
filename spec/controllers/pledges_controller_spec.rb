require 'rails_helper'

RSpec.describe PledgesController, type: :controller do
  let(:campaign) { create(:campaign) }
  let(:user)     { create(:user)     }

  describe "#create" do
    context "with user not signed in" do
      it "redirects to new session path" do
        post :create, pledge: {amount: 100}, campaign_id: campaign
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with user signed in" do
      before { request.session[:user_id] = user.id }

      context "with valid params" do
        def valid_request
          post :create, pledge: {amount: 100}, campaign_id: campaign
        end

        it "creates a pledge in the database" do
          expect { valid_request }.to change { Pledge.count }.by(1)
        end

        it "associates the pledge with the campaign" do
          expect { valid_request }.to change { campaign.pledges.count }.by(1)
        end

        it "redirects to the campaign page" do
          valid_request
          expect(response).to redirect_to(campaign)
        end

      end

      context "with invalid params" do
        def invalid_request
          post :create, pledge: {amount: 0}, campaign_id: campaign
        end
        it "doesn't change the pledge count" do
          expect { invalid_request }.to_not change { Pledge.count }
        end

        it "renders the campaign show page" do
          invalid_request
          expect(response).to render_template("campaigns/show")
        end
      end
    end
  end

end
