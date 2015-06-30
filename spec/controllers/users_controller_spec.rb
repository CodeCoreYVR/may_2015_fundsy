require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    it "assigns an instance variable @user" do
      # because we have RSpec.describe UsersController above
      # We're able to emulate a get / post / patch / delete
      # requests so we can use: VERB ACTION. e.g. get :new
      # or post :create
      get :new
      # assigns(:user) will check for an instance variable @user
      # be_a_new makes sure that @user is User.new
      expect(assigns(:user)).to be_a_new User
    end

    it "renders new.html.erb template file" do
      get :new
      # response is the controller response object that we get
      # we can check things like the template being rendered
      # we can also check redirects
      # render_template is an RSpec matcher that ensures that
      # a tempalte is rendered
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    # context is just an alias for describe
    context "with valid attributes" do
      def valid_request
        post :create, user: {first_name: "tam",
                             email: "tam@codecore.ca",
                             password: "abcd"}
      end

      it "save a user record in the database" do
        # before_count = User.count
        # post :create, user: {first_name: "tam",
        #                      email: "tam@codecore.ca",
        #                      password: "abcd"}
        # after_count = User.count
        # expect(after_count - before_count).to eq(1)
        expect { valid_request }.to change { User.count }.by(1)
      end

      it "redirects to root path" do
        valid_request
        expect(response).to redirect_to(root_path)
      end

      it "sets the session[:user_id] to be the created user id" do
        valid_request
        expect(session[:user_id]).to eq(User.last.id)
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context "with invalid attributes" do
      def invalid_request
        post :create, user: {first_name: "tam",
                             password: "abcd"}
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "doesn't change the user count" do
        expect { invalid_request }.to_not change { User.count }
      end

    end
  end
end
