require 'spec_helper'

describe "events/new" do
  before(:each) do
    assign(:event, stub_model(Event,
      :summary => "MyString",
      :description => "MyText",
      :uid => 1
    ).as_new_record)
  end

  it "renders new event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path, :method => "post" do
      assert_select "input#event_summary", :name => "event[summary]"
      assert_select "textarea#event_description", :name => "event[description]"
      assert_select "input#event_uid", :name => "event[uid]"
    end
  end
end
