require 'rails_helper'

RSpec.describe "discussions/new", type: :view do
  before(:each) do
    assign(:discussion, Discussion.new(
      :title => "MyString",
      :body => "MyText",
      :user => nil
    ))
  end

  it "renders new discussion form" do
    render

    assert_select "form[action=?][method=?]", discussions_path, "post" do

      assert_select "input#discussion_title[name=?]", "discussion[title]"

      assert_select "textarea#discussion_body[name=?]", "discussion[body]"

      assert_select "input#discussion_user_id[name=?]", "discussion[user_id]"
    end
  end
end
