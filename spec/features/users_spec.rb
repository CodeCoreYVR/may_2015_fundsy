require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe "Signing Up" do
    it "creates a user in the database and redirects to home page" do
      before_count = User.count

      visit new_user_path

      # this uses Factory Girl and gives us a valid set of user
      # attributes that we can use. We will get a Hash back
      valid_attributes = attributes_for(:user)

      # fill_in takes in either the label or the id of the field
      fill_in "First name", with: valid_attributes[:first_name]
      fill_in "Last name", with: valid_attributes[:last_name]
      fill_in "Email", with: valid_attributes[:email]
      fill_in "user_password", with: valid_attributes[:password]
      fill_in "user_password_confirmation", with: valid_attributes[:password]

      click_button "Create User"

      after_count = User.count

      expect(current_path).to eq(root_path)
      expect(after_count - before_count).to eq(1)

      # This command will open us a web page with the current staus
      # it requires the launchy gem to be installed
      # save_and_open_page

    end
  end
end
