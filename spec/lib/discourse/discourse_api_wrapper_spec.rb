require "spec_helper"

describe Discourse::DiscourseApiWrapper do
  before :each do
    @wrapper = Discourse::DiscourseApiWrapper.new
  end

  it "should return 3 most recent topics" do
    expect(@wrapper.recent_topics.length).to eq 3
  end

  it "recent topics should be the right class" do
    expect(@wrapper.recent_topics.first).to be_an_instance_of Discourse::Topic
  end
end
