require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "#new" do
    it "renders the new template (login form)" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "with valid credentials" do
      # the content of the before block will be executed before every
      # example within this context and sub contexts (or describes)
      before do
        @user = User.create(first_name: "abc",
                            email: "abc@abc.com",
                            password: "abcd1234")
        post :create, email: "abc@abc.com", password: "abcd1234"
      end

      it "sets the session[:user_id] to the logged in id" do
        expect(session[:user_id]).to eq(@user.id)
      end

      it "redirects to the root page" do
        expect(response).to redirect_to root_path
      end

      it "sets a flash message" do
        expect(flash[:notice]).to be
      end
    end

    context "with invalid credentials" do
      def request_with_invalid_password
        user = User.create(email: "e@e.ca", first_name: "abc", password: "abc")
        post :create, email: user.email, password: "invalid"
      end

      it "doesn't set the session[:user_id] with invalid email" do
        post :create, email: "I'm invalid"
        expect(session[:user_id]).to_not be
      end

      it "doesn't set the session[:user_id] with invalid password" do
        request_with_invalid_password
        expect(session[:user_id]).to_not be
      end

      it "renders the new template" do
        request_with_invalid_password
        expect(response).to render_template(:new)
      end

      it "sets a flash message" do
        request_with_invalid_password
        expect(flash[:alert]).to be
      end
    end
  end
end
