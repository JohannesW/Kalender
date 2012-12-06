require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :name => "Name",
      :pw => "Pw",
      :email => "Email",
      :uid => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Pw/)
    rendered.should match(/Email/)
    rendered.should match(/1/)
  end
end
