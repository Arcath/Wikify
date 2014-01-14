require 'spec_helper'

describe "User id storing" do
  it "should only be for that thread" do
    Wikify.user_id.should be_nil
    Thread.new do
      Wikify.set_user_id = 1
      Wikify.user_id.should eq 1
    end
    Wikify.user_id.should be_nil
  end
  
  it "should get set by the controller" do
    parent = Parent.new({name: "Committer 1"})
    parent.save
    parent
    controller = Controller.new
    controller.request # See this method for what it does
    parent = Parent.find_by_name("Committer 1 Updated")
    parent.versions.count.should eq 2
    parent.versions.last.comitter_id.should eq 1
  end
  
  it "should handle the current_user return being nil" do
    lambda { controller = NilController.new }.should_not raise_exception
  end
end