require 'rails_helper'

RSpec.describe "discussions/edit", type: :view do
  before(:each) do
    @discussion = assign(:discussion, Discussion.create!(
      :title => "MyString",
      :body => "MyText",
      :user => nil
    ))
  end

  it "renders the edit discussion form" do
    render

    assert_select "form[action=?][method=?]", discussion_path(@discussion), "post" do

      assert_select "input#discussion_title[name=?]", "discussion[title]"

      assert_select "textarea#discussion_body[name=?]", "discussion[body]"

      assert_select "input#discussion_user_id[name=?]", "discussion[user_id]"
    end
  end
end
