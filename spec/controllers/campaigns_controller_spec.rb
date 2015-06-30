require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiates a new Campaign variable" do
      get :new
      expect(assigns(:campaign)).to be_a_new Campaign
    end
  end

  describe "#create" do
    context "user not signed in" do
      it "redirects to sign in page" do
        post :create
        expect(response).to redirect_to new_session_path
      end
    end
    context "user signed in" do
      before do
        user = create(:user)
        # this is setting the session[:user_id] as part of the request
        request.session[:user_id] = user.id
      end

      context "with valid parameters" do
        def valid_request
          post :create, campaign: attributes_for(:campaign)
        end

        it "changes the campaings count by +1" do
          expect { valid_request }.to change { Campaign.count }.by(1)
        end

        it "redirects to the new campaign show page" do
          valid_request
          expect(response).to redirect_to campaign_path(Campaign.last)
        end

        it "sets a flash notice message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end

      context "with invalid parameters" do

      end
    end
  end
end
