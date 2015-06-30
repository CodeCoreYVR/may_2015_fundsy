require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "#new" do
    it "renders the new template (login form)"
  end

  describe "#create" do
    context "with valid credentials" do
      before do
        @user = User.create(first_name: "abc",
                            email: "abc@abc.com",
                            password: "abcd1234")
      end
      # post :create, email: "abc@abc.com", password: "abcd1234"
      it "sets the session[:user_id] to the logged in id"
      it "redirects to the root page"
      it "sets a flash message"
    end

    context "with invalid credentials" do
      # post :create, email: "I'm invalid"
      it "renders the new template"
      it "set a flash message"
    end
  end
end
