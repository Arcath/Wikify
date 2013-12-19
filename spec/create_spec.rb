require 'spec_helper'

describe "Model create" do
  it "should record a create event" do
    parent = Parent.new({name: "First Create Test"})
    parent.save
    
    parent.versions.count.should eq 1
    parent.versions.last.event.should eq "create"
  end
end