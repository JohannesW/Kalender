require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :name => "MyString",
      :pw => "MyString",
      :email => "MyString",
      :uid => 1
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
      assert_select "input#user_name", :name => "user[name]"
      assert_select "input#user_pw", :name => "user[pw]"
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_uid", :name => "user[uid]"
    end
  end
end
