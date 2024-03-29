require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do
  # this will give us a variable called `user` accessible anywhere within this
  # scope. It won't create the user in the database until you actually call
  # the variable or use let!
  let(:user)     { create(:user) }
  let(:user_1)   { create(:user) }
  let(:campaign) { create(:campaign, user: user) }

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

        it "associates the created campaign with the logged in user" do
          valid_request
          expect(Campaign.last.user).to eq(user)
        end
      end

      context "with invalid parameters" do
        def invalid_request
          post :create, campaign: attributes_for(:campaign).merge({title: nil})
        end

        it "renders the new template (form)" do
          invalid_request
          expect(response).to render_template(:new)
        end

        it "doesn't change the campaigns count" do
          expect { invalid_request }.to_not change { Campaign.count }
        end

      end
    end
  end

  describe "#edit" do
    context "user not signed in" do
      it "redirects to the new session path" do
        get :edit, id: campaign.id
        expect(response).to redirect_to new_session_path
      end
    end
    context "user signed in" do
      before do
        request.session[:user_id] = user.id
      end

      context "user is owner of campaign" do
        it "renders the edit template" do
          get :edit, id: campaign.id
          expect(response).to render_template(:edit)
        end
        it "instantiates the campaign instance variable with the id passed" do
          get :edit, id: campaign.id
          expect(assigns(:campaign)).to eq(campaign)
        end
      end
      context "user is not the owner of the campaign" do
        before do
          request.session[:user_id] = user_1.id
        end

        it "throws an error" do
          expect { get :edit, id: campaign.id }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  describe "#show" do
    before { get :show, id: campaign.id }

    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "instantiates an instance variable with the passed id" do
      expect(assigns(:campaign)).to eq(campaign)
    end
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "instantiates campaigns variable a list of all campaigns in DB" do
      campaign # this calls the variable in the `let` which creates a campaign
      campaign_1 = create(:campaign)
      get :index
      expect(assigns(:campaigns)).to eq([campaign, campaign_1])
    end
  end

  describe "#update" do
    context "with user not signed in" do
      it "redirects to sign in page" do
        patch :update, id: campaign.id
        expect(response).to redirect_to(new_session_path)
      end
    end
    context "with user signed in" do
      before do
        request.session[:user_id] = user.id
      end

      context "user is not the owner of the campaign" do
        it "raises an error" do
          request.session[:user_id] = user_1.id
          # expect { patch :update, id: campaign.id }.to raise_error(ActiveRecord::RecordNotFound)
          expect do
            patch :update, id: campaign.id
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
      context "user is the owner of the campaign" do
        context "with valid update attributes" do
          before do
            patch :update, id: campaign.id, campaign: {title: "abc"}
          end

          it "updates the passed values in the database" do
            expect(campaign.reload.title).to eq("abc")
          end

          it "redirects to the show page" do
            expect(response).to redirect_to(campaign_path(campaign))
          end

          it "sets a flash message" do
            expect(flash[:notice]).to be
          end
        end
        context "with invalid update attributes" do
          before do
            patch :update, id: campaign.id, campaign: {title: "", description: "abc"}
          end

          it "doesn't update any field in the database" do
            expect(campaign.reload.description).to_not eq("abc")
          end

          it "renders the edit page" do
            expect(response).to render_template(:edit)
          end

          it "sets a flash message" do
            expect(flash[:alert]).to be
          end
        end
      end
    end
  end

  describe "#destroy" do
    context "without a signed in user" do
      it "redirects to new session path" do
        delete :destroy, id: campaign.id
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "with signed in user" do
      before { request.session[:user_id] = user.id }
      context "with non-owner logged in" do
        it "raises an error" do
          request.session[:user_id] = user_1.id
          expect do
            delete :destroy, id: campaign.id
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
      context "with the owner logged in" do
        # def delete_request
        #   delete :destroy, id: campaign.id
        # end
        before { delete :destroy, id: campaign.id }

        it "removes the campaign from the database" do
          expect(Campaign.find_by_id(campaign.id)).to_not be
          # campaign
          # expect { delete_request }.to change { Campaign.count }.by(-1)
        end

        it "redirects to the index page" do
          expect(response).to redirect_to(campaigns_path)
        end

        it "sets a flash message" do
          expect(flash[:notice]).to be
        end
      end
    end
  end
end
