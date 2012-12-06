require 'spec_helper'

describe "events/edit" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :summary => "MyString",
      :description => "MyText",
      :uid => 1
    ))
  end

  it "renders the edit event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => events_path(@event), :method => "post" do
      assert_select "input#event_summary", :name => "event[summary]"
      assert_select "textarea#event_description", :name => "event[description]"
      assert_select "input#event_uid", :name => "event[uid]"
    end
  end
end
