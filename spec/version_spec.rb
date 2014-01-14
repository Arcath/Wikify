require 'spec_helper'

describe Wikify::Version do
  it "should create a struct for your data" do
    version = Wikify::Version.last
    version.object.should be_a OpenStruct
  end
  
  it "should have a link to the previous version" do
    version = Wikify::Version.last
    version.previous.should be_a Wikify::Version
  end
  
  it "should have a link to the next version" do
    version = Wikify::Version.last
    prev = version.previous
    prev.next.should be_a Wikify::Version
  end
  
  it "should return the current model for next if it is the latest version" do
    version = Wikify::Version.last
    version.next.should be_a version.restore_type.constantize
  end
  
  it "should find the version at a specified time" do
    parent = Parent.new({name: 'Time Test'})
    parent.save
    sleep 3
    parent = Parent.find(parent.id)
    parent.name = "Time Test 1"
    parent.save
    sleep 1
    version = parent.version_at(Time.now - 3)
    version.should be_a Wikify::Version
    version.object.name.should eq "Time Test"
  end
end