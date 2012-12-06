require 'spec_helper'

describe "events/show" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :summary => "Summary",
      :description => "MyText",
      :uid => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Summary/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
