require 'rails_helper'

RSpec.feature "Campaigns", type: :feature do
  describe "Home Page" do
    it "displays a welcome message" do
      visit campaigns_path
      expect(page).to have_text("Welcome to Fund.sy")
    end

    it "have a html page title of 'Fund.sy'" do
      visit campaigns_path
      expect(page).to have_title("Fund.sy")
    end

    it "has an h2 element that says 'All Campaigns'" do
      visit campaigns_path
      expect(page).to have_selector("h2", "All Campaigns")
    end

    context "displaying campaigns" do
      # let! will always execute the statement in the let whether
      # you call it or not
      let!(:campaign) { create(:campaign) }

      it "displays the campaign title" do
        visit campaigns_path
        expect(page).to have_text /#{campaign.title}/i
      end
    end

    context "diplaying a single campaign" do

      it "diplays the campaign title in a h1 element"
      it "displays the campaign body"

    end
  end
end
