require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  let(:user) { create(:user) }

  context "logging in user" do
    context "successful login" do
      it "redirects to the home page" do
        visit new_session_path

        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"

        expect(current_path).to eq(root_path)
        expect(page).to have_text /Logged in/i
        expect(page).to have_text /#{user.full_name}/i
      end
    end
    context "unsuccessful login" do
      it "stays on the sessions path" do
        visit new_session_path

        fill_in "Email", with: user.email
        fill_in "Password", with: "Adfasjdfhkajsdfhkasdf"
        click_button "Log in"

        expect(current_path).to eq(sessions_path)
        expect(page).to_not have_text /#{user.full_name}/i
      end

    end
  end
end
